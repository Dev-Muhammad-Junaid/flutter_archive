import 'dart:async';

// StreamController<String> _streamController = StreamController<String>();
StreamController<String> _streamController =
StreamController<String>.broadcast();
Stream<String> get stream => _streamController.stream;

void main() {
  stream.listen((data) {
    print(data);
  });

  stream.listen((data) {
    print(data.replaceAll("a", "b"));
  });

  void add() {
    _streamController.add("somedata");
  }

  add();
}
