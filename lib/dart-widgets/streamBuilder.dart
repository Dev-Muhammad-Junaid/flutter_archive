import 'dart:async';

import 'package:flutter/material.dart';

class StreamContainer {
  final StreamController<int> _numberController =
      StreamController<int>.broadcast();

  Stream<int> get outStream => _numberController.stream;

  Sink<int> get inStream => _numberController.sink;

  void dispose() {
    _numberController.close();
  }
}

class StreamWidget extends StatelessWidget {
  final model = StreamContainer();

  StreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[],
    );
  }
}

Stream<int> getNumbers() async* {
  for (int i = 1; i <= 10; i++) {
    yield i;
    await Future.delayed(Duration(milliseconds: 500));
  }
}

