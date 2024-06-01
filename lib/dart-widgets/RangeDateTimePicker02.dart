import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({
    Key? key,
    this.width,
    this.height,
    this.initialStartDate,
    this.initialEndDate,
    this.fontColor,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
    this.pickerWidth,
    this.pickerHeight,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final int? outlineWidth;
  final int? pickerWidth;
  final int? pickerHeight;

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTimeRange? selectedDateRange; // Corrected type reference here

  @override
  void initState() {
    super.initState();
    if (widget.initialStartDate != null && widget.initialEndDate != null) {
      selectedDateRange = DateTimeRange(
          start: widget.initialStartDate!, end: widget.initialEndDate!);
    }
  }

  void showCustomDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: selectedDateRange,
      builder: (context, child) {
        // Apply constraints to the date picker dialog
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: widget.pickerWidth?.toDouble() ??
                  400.0, // Adjust the width as needed
              maxHeight: widget.pickerHeight?.toDouble() ??
                  MediaQuery.of(context).size.height *
                      0.8, // Optionally limit the height
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
        // FFAppState().startDate = picked.start;
        // FFAppState().endDate = picked.end;
        // widget.updatePageUI();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 50.0,
      child: ElevatedButton(
        onPressed: showCustomDateRangePicker,
        child: Padding(
          padding:
          const EdgeInsets.all(8.0), // Adjust the padding value as needed
          child: selectedDateRange != null
              ? Text(
            '${DateFormat('yyyy-MM-dd').format(selectedDateRange!.start)} to ${DateFormat('yyyy-MM-dd').format(selectedDateRange!.end)}',
            style: TextStyle(
              color: widget.fontColor ??
                Colors.deepPurpleAccent
                  // FlutterFlowTheme.of(context).primaryText,
            ),
          )
              : Text(
            'Select Date Range',
            style: TextStyl e(
              color: widget.fontColor ??
                  Colors.deepPurpleAccent,
                  // FlutterFlowTheme.of(context).primaryText,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ??
              Colors.deepPurpleAccent,
              // FlutterFlowTheme.of(context).secondaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: widget.outlineColor ?? Colors.transparent,
              width: widget.outlineWidth?.toDouble() ?? 0,
            ),
          ),
        ),
      ),
    );
  }
}