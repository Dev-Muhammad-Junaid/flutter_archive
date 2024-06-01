// import 'package:flutter/material.dart';
// import 'package:custom_date_range_picker/custom_date_range_picker.dart';
//
// class SomeRandomDateTimePicker extends StatefulWidget  {
//   const SomeRandomDateTimePicker({super.key});
//
//   @override
//   State<SomeRandomDateTimePicker> createState() => _SomeRandomDateTimePickerState();
// }
//
// class _SomeRandomDateTimePickerState extends State<SomeRandomDateTimePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Date Range",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//                 child: Builder(
//                   builder: (context) {
//                     return ElevatedButton(
//                         onPressed: () {
//                           showCustomDateRangePicker(
//                               context,
//                               dismissible: true,
//                               minimumDate: DateTime.now(),
//                               maximumDate: DateTime.now()
//                                   .add(const Duration(hours: 5000000)),
//                               onApplyClick: (start, end) {},
//                               onCancelClick: () {
//                             setState(() {
//                               // return null dates and handle logic carefully
//                             });
//                           },
//                               backgroundColor: Colors.deepPurpleAccent,
//                               primaryColor: Colors.black45);
//                         },
//                         child: Text("Date Picker"));
//                   }
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
