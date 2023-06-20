import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:convert';
import 'image_card.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void navigateToImageDetailsPage(BuildContext context,
      {required String title,
      required String imageUrl,
      required String datetime}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ImageFromURL(title: title, imageUrl: imageUrl, datetime: datetime),
      ),
    );
  }

  Future<void> initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  Future<void> uploadImageToServer(String imageUrl) async {
    try {
      var dio = Dio();
      var data = {
        'imageUrl': imageUrl,
      };

      dio.options.contentType = Headers.formUrlEncodedContentType;
      var response = await dio.post(
        'http://7d54-35-199-168-173.ngrok-free.app/upload',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        var imageLink = responseData['image_link'];
        var date = responseData['datetime'];
        var caption = responseData['caption'];

        print('Image Link: $imageLink');
        print('Date: $date');
        print('Caption: $caption');
        navigateToImageDetailsPage(context,
            title: caption, imageUrl: imageLink, datetime: date);
      } else {
        print(
            'Error uploading image to the server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image to the server: $e');
    }
  }

  Future<void> uploadImageToFirebase(String uid) async {
    if (imageFile == null) return;

    try {
      // Create a unique filename for the image
      final fileName = '${DateTime.now()}.png';

      // Get the reference to the Firebase Storage bucket
      final firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      // Upload the image file to Firebase Storage
      await ref.putFile(imageFile);

      // Get the download URL of the uploaded image
      final imageUrl = await ref.getDownloadURL();

      // Print the download URL (you can save it to a database if needed)
      print('Image uploaded. Download URL: $imageUrl');

      await uploadImageToServer(imageUrl);

      // Create a Map object containing the data to be sent in the request body
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  late File imageFile;

  Future<void> openCamera() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> captureImage() async {
    await openCamera();
    // Pass the user ID to the uploadImageToFirebase method
    final uid = _auth.currentUser?.uid; // Replace with the actual user ID
    await uploadImageToFirebase(uid!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 400),
        Center(
          child: Container(
            width: 200.0,
            height: 200.0,
            child: FloatingActionButton(
              onPressed: captureImage,
              child: Icon(
                Icons.camera_alt,
                size: 100,
              ),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
