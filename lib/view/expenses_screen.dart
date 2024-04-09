import 'package:expense_tracker/view/new_expenses_screen.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/widgets.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Fit Course', 
      amount: 18.02, 
      date: DateTime.now(),
      category: ExpenseCategory.work,  
    ),
    ExpenseModel(
      title: 'Pork',
      amount: 0.95,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
  ];
  
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => const NewExpenseScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses)
          ),
        ],
      ),
    );
  }
}