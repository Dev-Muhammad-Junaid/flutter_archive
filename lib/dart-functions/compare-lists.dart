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
        'Acceso a Bodegas de Vinos Exclusivas',
        'Estilista Personal',
        'Confección a Medida',
        'Limpieza Integral',
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
