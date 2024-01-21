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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedButton(
                text: "Junaid",
                gradientStyle: "Rainbow",
                containerWidth: 200,
                // Custom width
                containerHeight: 200,
                // Custom height
                containerMargin: const EdgeInsets.all(2),
                // Custom margin
                containerPadding: const EdgeInsets.all(20),
                // Custom padding
                containerColor: Colors.teal,
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
    );
  }
}
