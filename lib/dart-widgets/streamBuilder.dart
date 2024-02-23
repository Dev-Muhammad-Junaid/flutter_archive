import 'package:flutter/material.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget({super.key});

  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

Stream<int> getNumbers() async* {
  for (int i = 0; i <= 10; i++) {
    yield i;
  }
  await Future.delayed(Duration(seconds: 3));
}

class _StreamWidgetState extends State<StreamWidget> {
  int currentNumber = 0;

  void initState() {
    getNumbers().listen((event) {
      setState(() {
        currentNumber = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(stream: getNumbers(), builder: (context, snapshot) {
          return Text(snapshot.hasData ? snapshot.data.toString() : "unset",
            style: TextStyle(fontSize: 45));
        }),

      ],
    );
  }
}
