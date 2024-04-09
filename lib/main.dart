import 'package:expense_tracker/view/expenses_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: ExpensesScreen(),
    )
  );
}
