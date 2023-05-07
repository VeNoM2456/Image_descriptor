import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await Dio().get('http://abb6-27-61-3-212.ngrok-free.app/get_processed_image');

      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        // Handle error
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Page'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = data[index];
          final imageUrl = item['image'];
          final caption = item['caption'];
          final time = item['time'];

          return Card(
            child: ListTile(
              leading: imageUrl != null
                  ? Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : Container(width: 50, height: 50), // Placeholder for no image
              title: Text(caption ?? ''),
              subtitle: Text(time ?? ''),
            ),
          );
        },
      ),
    );
  }
}
