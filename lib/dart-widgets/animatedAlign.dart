import 'package:flutter/material.dart';

class AnimatedAlignWidget extends StatefulWidget {
  const AnimatedAlignWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedAlignWidget> createState() => _AnimatedAlignWidgetState();
}

class _AnimatedAlignWidgetState extends State<AnimatedAlignWidget> {
  bool animatePosition = false;
  Alignment currentAlignment = Alignment.topLeft;
  late Alignment resultAlignment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      animatePosition = true;
                      resultAlignment = Alignment.topLeft;
                    });
                  },
                  child: const Text("TopLeft"),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      animatePosition = true;
                      resultAlignment = Alignment.topCenter;
                    });
                  },
                  child: const Text("TopCenter"),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      animatePosition = true;
                      resultAlignment = Alignment.topRight;
                    });
                  },
                  child: const Text("TopRight"),
                ),
              ),
              // same for other alignment
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius:BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 500,
            child: AnimatedAlign(
              alignment: animatePosition ? resultAlignment : currentAlignment,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Container(
                color: Colors.cyan,
                height: 100,
                width: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}