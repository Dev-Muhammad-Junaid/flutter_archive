import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Set<int> compare_lists() {
  var list1 = [1, 2, 3, 4, 5];
  var list2 = [1, 2, 3, 4, 5];
  return list1.toSet();
}

String? splitName(
  String name,
  bool isFirstName,
) {
  final splittedName = name.split(' ');
  if (splittedName.length < 2) {
    return name;
  }
  if (isFirstName) {
    return splittedName[0]; //retuns First Name
  }
  return splittedName[1]; // returns Last Name
}

Future<int> compareDatesDifference(
    DateTime date1,
    DateTime date2,
    ) async {
  //Calculate Difference
  Duration difference = date1.difference(date2);

  // Convert the difference to days
  int days = difference.inDays;
  // Return Days Difference
  return days;
}

//Get Location in Latitude or Longitude
String latLongString(
    var location,
    bool isLat,
    ) {
  if (isLat) {
    return location.latitude.toString();
  } else {
    return location.longitude.toString();
  }
}
//->Get Category List based on nested inputs
String? getCategoryList(String languageCode,String category){
  final Map<String, Map<String, List<String>>> categories = {
    'en': {
      'Accommodation': [
        'Private Island Retreats',
        'Historic Castle Stays',
        'Ultra-Luxury Chalets',
      ],
      'Services': [
        'Personal Butler Services',
        'Fine Art Curator',
        'Consultation',
      ],
      // Add other categories and translations here
    },
    'es': {
      'Accommodation': [
        'Suites Ático',
        'Villas de Lujo',
        'Apartamentos Elegantes',
        'Mansiones Opulentas',
      ],
      'Services': [
        'Servicios de Mayordomo Personal',
        'Curador de Bellas Artes',
        'Consulta',
      ],
      // Add other categories and translations here
    },
    // Add translations for other languages here
  };

  final categoryMap = categories[languageCode];
  if (categoryMap != null) {
    final categoryList = categoryMap[category];
    if (categoryList != null) {
      return categoryList.join('\n');
    }
  }
  return null; // Language or category not found in categories
}

//Chat Gpt 3.5 Turbo Function
Future<String> getGPT3Completion(
    String apiKey,
    String userPrompt,
    int maxTokens,
    double temperature,
    ) async {
//messages from JSON DECODE
  dynamic messages =
  json.decode('[{"role": "user", "content": "$userPrompt"}]');

  final data = {
    "model": "gpt-3.5-turbo-1106",
    "messages": messages,
    'max_tokens': maxTokens,
    'temperature': temperature,
  };

  final headers = {
    'Authorization':
    'Bearer $apiKey',
    'Content-Type': 'application/json'
  };
  final request = http.Request(
    'POST',
    Uri.parse('https://api.openai.com/v1/chat/completions'),
  );
  request.body = json.encode(data);
  request.headers.addAll(headers);

  final httpResponse = await request.send();

  if (httpResponse.statusCode == 200) {
    final jsonResponse = json.decode(await httpResponse.stream.bytesToString());
    String responseText = jsonResponse['choices'][0]['message']['content'];

    return ' ' + responseText.trim();
  } else {
    print(httpResponse.reasonPhrase);
    return '';
  }
}

//->Lock App Orientation
Future lockOrientation() async {
  //supports landscapeLeft,landscapeRight, portraitUp, portraitDown
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
//->Return number with Fixed decimal points
String? numberDecimals(double? number,int decimalPoint) {
  /// MODIFY CODE ONLY BELOW THIS LINE
  // must return amount with 2 decimal points
  if (number == null) {
    return null;
  } else {
    return number.toStringAsFixed(decimalPoint);
  }
  /// MODIFY CODE ONLY ABOVE THIS LINE
}

//->Add or Remove from List
void numbersList() {
  List<int> numbers = [1, 2, 3, 4, 5];
  numbers.add(6);
  numbers.remove(3);
  print(numbers); // Output: [1, 2, 4, 5, 6]
}

//->Expand Nested List
void ExpandNestedList() {
  List<List<int>> nestedList = [[1, 2], [3, 4], [5, 6]];
  List<int> flatList = nestedList.expand((list) => list).toList();
  print(flatList); // Output: [1, 2, 3, 4, 5, 6]
}

//->Sort Items Alphabetically in Dart where Any is always first
List<String> SortItems(List<String> states) {
  states.sort((a, b) {
    if (a == 'Any') {
      return -1; // 'Any' comes first
    } else if (b == 'Any') {
      return 1; // 'Any' comes after
    } else {
      return a.compareTo(b); // Compare other items alphabetically
    }
  });
  print(states);
  return(states);
}

//Sort List by Length
List<String> sortByLength(List<String> strings) {
  strings.sort((a, b) => a.length.compareTo(b.length));
  return strings;
}

//Find most frequent number
int findMostFrequent(List<int> list) {
  var frequencyMap = <int, int>{};
  for (var item in list) {
    frequencyMap.update(item, (value) => value + 1, ifAbsent: () => 1);
  }
  return frequencyMap.entries.reduce((a, b) => a.value > b.value ? a : b).key;
}

//Add Days to Date

String addtoDate(
    DateTime? date,
    int daystoAdd,
    ) {

  // add days to date
  // DateTime date = DateTime.now();
  if (date == null) return "1/23/1234";

  DateTime newDate = date.add(Duration(days: daystoAdd));
  return DateFormat.yMd().format(newDate);
  // return DateFormat.yMMMMd().format(newDate);
  // return DateFormat('yyyy-MM-dd').format(newDate);
  print("Passed Date : ${DateFormat.yMMMMd().format(date!)}");

  /// MODIFY CODE ONLY ABOVE THIS LINE
}