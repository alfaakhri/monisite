import 'package:flutter/material.dart';

class DatePicker {
  DateTime selectedDate = DateTime.now();

  DatePicker({this.selectedDate});

  Future selectDate(BuildContext context) async {
    DateTime _selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) return selectedDate = picked;
  }
}
