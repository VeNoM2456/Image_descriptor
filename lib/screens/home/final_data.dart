import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:rive_animation/screens/home/components/image_card.dart';
import '../onboding/components/datapage.dart';
import 'components/camera.dart';
import '../../model/course.dart';
import 'components/camera.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';

class FinalData extends StatelessWidget {
  const FinalData({Key? key});

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 40),
              Padding(
              padding: const EdgeInsets.all(20),
          child: Text(
            "Image Caption",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

    ],
    ),
    ),
    ),
    );
  }
}
