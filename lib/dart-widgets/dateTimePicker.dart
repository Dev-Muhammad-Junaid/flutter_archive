import 'package:flutter/material.dart';

class RangeDateTimePicker extends StatelessWidget {
  const RangeDateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Date Time",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Open Date Picker")),

        ],
      ),
    );
  }
}
