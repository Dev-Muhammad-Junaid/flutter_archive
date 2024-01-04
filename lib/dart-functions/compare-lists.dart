


Set<int> compare_lists()
{
  var list1 = [1,2,3,4,5];
  var list2 = [1,2,3,4,5];
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