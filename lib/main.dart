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
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(padding: const EdgeInsets.all(10.0),),
                AnimatedButton(
                    text: "Hello",
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
                Padding(padding: const EdgeInsets.all(10.0),),
                AnimatedButton(
                    text: "World",
                    gradientStyle: "PastelDreams",
                    containerWidth: 200,
                    // Custom width
                    containerHeight: 200,
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
                Padding(padding: const EdgeInsets.all(10.0),),
                AnimatedButton(
                    text: "Junaid",
                    gradientStyle: "MysticalTwilight",
                    containerWidth: 100,
                    // Custom width
                    containerHeight: 100,
                    // Custom height
                    containerMargin: const EdgeInsets.all(2),
                    // Custom margin
                    containerPadding: const EdgeInsets.all(20),
                    // Custom padding
                    containerColor: Colors.black,
                    // Custom background color
                    containerOpacity: 0.1,
                    // Custom opacity
                    borderRadius: 0,
                    // Custom border radius
                    animationDuration: Duration(seconds: 2),
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )), Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                AnimatedButton(
                    text: "Junaid",
                    gradientStyle: "Blink",
                    containerWidth: 100,
                    // Custom width
                    containerHeight: 100,
                    // Custom height
                    containerMargin: const EdgeInsets.all(2),
                    // Custom margin
                    containerPadding: const EdgeInsets.all(20),
                    // Custom padding
                    containerColor: Colors.transparent,
                    // Custom background color
                    containerOpacity: 0.1,
                    // Custom opacity
                    borderRadius: 0,
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
      ),
    );
  }
}
