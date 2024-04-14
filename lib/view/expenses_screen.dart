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
      isScrollControlled: true, // 占滿螢幕
      context: context, 
      builder: (ctx) => NewExpenseScreen(onAddExpense: _addExpense,));
  }

  // 新增記帳資料
  void _addExpense(ExpenseModel expenseModel) {
    setState(() {
      _registeredExpenses.add(expenseModel);
    });
  }

  // 刪除記帳資料
  void _removeExpense(ExpenseModel expenseModel) {
    final expenseIndex = _registeredExpenses.indexOf(expenseModel);
    setState(() {
      _registeredExpenses.remove(expenseModel);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('此筆記錄已被刪除'),
        action: SnackBarAction(
          label: '取消刪除', 
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expenseModel);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('無任何記帳資料，開始你的記錄吧!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
              );
    }   
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
            child: mainContent
          ),
        ],
      ),
    );
  }
}