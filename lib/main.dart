import 'package:flutter/material.dart';
import 'package:flutter_archive/dart-widgets/animatedAlign.dart';
import 'package:flutter_archive/dart-widgets/animatedButton.dart';

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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                Builder(
                  builder: (context){
                  return ElevatedButton(
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AnimatedAlignWidget())
                      ),
                      child: Text("Animated Align"),
                );}),
                const StreamWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
