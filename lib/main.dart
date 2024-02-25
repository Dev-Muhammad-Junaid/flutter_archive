import 'package:flutter/material.dart';
import 'package:flutter_archive/dart-widgets/animatedAlign.dart';
import 'package:flutter_archive/dart-widgets/animatedButton.dart';
import 'package:flutter_archive/dart-widgets/animtedSlider.dart';
import 'package:flutter_archive/pages/blog_post_widget.dart';

import 'dart-widgets/streamBuilder.dart';

void main() {
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
                AnimatedSlider(
                  leftFillColor: Colors.orange.shade400,
                  height: 60,
                  value: 0.4,
                  cornerRadius: BorderRadius.circular(1000),
                  onChange: (value) {},
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnimatedAlignWidget())),
                    child: Text("Animated Align"),
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
                AnimatedSlide(offset: Offset.infinite, duration: Duration(seconds: 3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
