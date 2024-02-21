void main() {
  // singleWhere();
  // firstWhere();
  // lastWhere();
  // first();
  // single();
  // last();
  // any();
  // elementAt();
  // contains();
  // join();
  // every();
  // length();
  // isEmpty();
  // listen();
  // awaitFor();
  // SumNumbers();
  // getNumbers();
  // getNumbersException();

  //----
  expand();
}

// Stream Function Basic
Stream<int> getNumbers() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

Stream<int> getNumbersEx() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
    if (i == 2) {
      throw Exception();
    }
  }
}

// Stream Function Exception
void getNumbersException() {
  getNumbersEx().listen((data) {
    print(data);
  }).onError((error) {
    print("an Error Occured");
  });
}

//Listen to Stream
void listen() {
  print(getNumbers().listen((data) => print(data)));
}

// Sum Stream Data once completed
var sum = 0;
void SumNumbers() {
  getNumbers().listen((data) {
    print(data);
    sum += data;
  }).onDone(() {
    print("Sum : $sum");
  });
}

//Wait for all Numbers and then Execute
void awaitFor() async {
  var sum = 0;
  await for (var number in getNumbers()) {
    sum += number;
    print(number);
  }
  print("Sum : $sum");
}

// Check if stream is Empty or not.
void isEmpty() async {
  if (await getNumbers().isEmpty) {
    print("Stream is Empty");
  } else
    print("Stream Not Empty");
}

//First Stream value and terminate
void first() async {
  print(await getNumbers().first);
}

//Last Stream value
void last() async {
  print(await getNumbers().last);
}

//Stream length (counts yields )
void length() async {
  print(await getNumbers().length);
}

//Stream only one element (error if more than 1)

void single() async {
  print(await getNumbers().single);
}

// Finds any single value and terminates [Boolean] [Provides CallBack]
void any() async {
  if (await getNumbers().any((element) => element > 1)) {
    print("Value found 2");
  } else {
    print("Value not found ");
  }
}

// Finds if Stream contains and terminates [Boolean]

void contains() async {
  if (await getNumbers().contains(0)) {
    print("Value Found");
  } else {
    print("Value not found");
  }
}
// Finds Element At index

void elementAt() async {
  print(await getNumbers().elementAt(2));
}

// Finds Element from Last to start

void lastWhere() async {
  print(await getNumbers().lastWhere((element) => element == 1));
}

// Finds Element from First to Last

void firstWhere() async {
  print(await getNumbers().firstWhere((element) => element == 3));
}

// Finds Single Element Occurence, reads entire stream
void singleWhere() async {
  print(await getNumbers().singleWhere((element) => element <= 1));
}

//Check every element from stream, [Boolean] [Callback]
void every() async {
  print(await getNumbers().every((element) => element > 3));
}

//join a String with every stream
void join() async {
  print(await getNumbers().join("-"));
}

void expand() async {
  print(await getNumbers().expand((element) => [element > 0]));
}
