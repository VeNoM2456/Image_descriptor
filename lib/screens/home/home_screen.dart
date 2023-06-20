import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../onboding/components/datapage.dart';
import 'components/camera.dart';
import '../../model/course.dart';
import 'components/camera.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 40),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Text(
                //     "Courses",
                //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //         ),
                //   ),
                // ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: courses
                //         .map(
                //           (course) => Padding(
                //         padding: const EdgeInsets.only(left: 20),
                //         child: CourseCard(
                //           title: course.title,
                //           iconSrc: course.iconSrc,
                //           color: course.color,
                //         ),
                //       ),
                //     )
                //         .toList(),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Text(
                //     "Recent",
                //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //         ),
                //   ),
                // ),
                const CameraPage(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
