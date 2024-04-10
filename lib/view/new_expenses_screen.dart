import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/model/expense_model.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async{
    // 範圍一年前至今
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: const InputDecoration(
                  prefixText: '\$ ',
                  label: Text('Amount')
                ),
                          ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null? 'No date selected' : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker, 
                      icon: const Icon(
                        Icons.calendar_month
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: (){
                  // 關閉BottomSheet
                  Navigator.pop(context);
                }, 
                child: const Text('Cancel')
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                }, 
                child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}