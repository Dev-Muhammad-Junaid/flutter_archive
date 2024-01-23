import 'package:flutter/material.dart';
import 'package:flutter_archive/dart-widgets/animatedButton.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedButton(
                  text: "",
                  gradientStyle: "Trident",
                  containerWidth: 200,
                  // Custom width
                  containerHeight: 100,
                  // Custom height
                  containerMargin: const EdgeInsets.all(1),
                  // Custom margin
                  containerPadding: const EdgeInsets.all(20),
                  // Custom padding
                  containerColor: Colors.black38,
                  // Custom background color
                  containerOpacity: 0.8,
                  // Custom opacity
                  borderRadius: 20,
                  // Custom border radius
                  animationDuration: Duration(seconds: 2),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              AnimatedButton(
                  text: "",
                  gradientStyle: "PastelDreams",
                  containerWidth: 200,
                  // Custom width
                  containerHeight: 400,
                  // Custom height
                  containerMargin: const EdgeInsets.all(2),
                  // Custom margin
                  containerPadding: const EdgeInsets.all(20),
                  // Custom padding
                  containerColor: Colors.white10,
                  // Custom background color
                  containerOpacity: 0.8,
                  // Custom opacity
                  borderRadius: 20,
                  // Custom border radius
                  animationDuration: Duration(seconds: 2),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
