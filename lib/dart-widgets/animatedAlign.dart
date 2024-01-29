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
      backgroundColor: Colors.blueGrey.shade700,
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
          child: Wrap(
            runSpacing: 10,
            spacing: 5,
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.spaceAround,
            children:[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    animatePosition = true;
                    resultAlignment = Alignment.topLeft;
                  });
                },
                child: const Text("TopLeft"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    animatePosition = true;
                    resultAlignment = Alignment.topCenter;
                  });
                },
                child: const Text("TopCenter"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    animatePosition = true;
                    resultAlignment = Alignment.topRight;
                  });
                },
                child: const Text("TopRight"),
              ), ElevatedButton(
                onPressed: () {
                  setState(() {
                    animatePosition = true;
                    resultAlignment = Alignment.bottomLeft;
                  });
                },
                child: const Text("BottomLeft"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    animatePosition = true;
                    resultAlignment = Alignment.bottomCenter;
                  });
                },
                child: const Text("BottomCenter"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    animatePosition = true;
                    resultAlignment = Alignment.bottomRight;
                  });
                },
                child: const Text("BottomRight"),
              ),
          ]),
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
            height: 300,
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