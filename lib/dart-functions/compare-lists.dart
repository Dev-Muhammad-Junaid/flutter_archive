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