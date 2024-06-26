import 'package:flutter/material.dart';
import 'package:flutter_archive/dart-widgets/animatedAlign.dart';
import 'package:flutter_archive/dart-widgets/animatedButton.dart';
import 'package:flutter_archive/dart-widgets/animtedSlider.dart';
import 'package:flutter_archive/pages/blog_post_widget.dart';
import 'package:flutter_archive/viewmodels/blog_post_vm.dart';
import 'dart-widgets/RangeDateTimePicker.dart';
import 'package:get_it/get_it.dart';

import 'dart-widgets/RangeDateTimePicker02.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => BlogPostViewModel());
}

void main() {
  setupLocator();
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Gradients(
                    animationDuration: 3,
                    borderRadius: 25,
                    borderWidth: 2,
                    containerColor: Colors.transparent,
                    gradientStyle: "Beach",
                    height: 50,
                    width: 10,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Gradients(
                    animationDuration: 3,
                    borderRadius: 25,
                    borderWidth: 2,
                    containerColor: Colors.transparent,
                    gradientStyle: "Trident",
                    height: 20,
                    width: 50,
                  ),
                ),
                InteractiveSlider(
                  leftFillColor: Colors.orange.shade400,
                  height: 60,
                  value: 0.4,
                  cornerRadius: BorderRadius.circular(0),
                  onChange: (value) {},
                ),
                Padding(padding: EdgeInsets.all(50)),
                InteractiveSlider(
                  value: 0.9,
                  onChange: (value) {},
                ),

                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnimatedAlignWidget())),
                    child: const Text("Animated Align"),
                  );
                }),
                // Builder(builder: (context) {
                //   return ElevatedButton(
                //     onPressed: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const SomeRandomDateTimePicker())),
                //     child: const Text("Range Date Picker 01"),
                //   );
                // }),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DateRangePicker(
                              height: 400,
                              width: 300,
                              backgroundColor: Colors.black45,
                              fontColor: Colors.white,

                                ))),
                    child: const Text("Range Date Picker 02"),
                  );
                }),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlogPostWidget()),
                    ),
                    child: const Text("Blogs Streaming"),
                  );
                }),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlogPostWidget()),
                    ),
                    child: Text("Blogs"),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
