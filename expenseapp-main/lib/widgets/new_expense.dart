import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.onAdd}) : super(key: key);

  final void Function(Expense expense) onAdd;

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();
  late Category _selectedCategory = Category.food; 
  //chartı ekle

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addNewExpense() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null ||
        amount < 0 ||
        _nameController.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Please fill all blank areas."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"),
              )
            ],
          );
        },
      );
    } else {
      Expense expense = Expense(
          name: _nameController.text,
          price: amount,
          date: _selectedDate!,
          category: _selectedCategory);
      widget.onAdd(expense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _nameController,
          maxLength: 50,
          decoration: const InputDecoration(labelText: "Expense Name"),
        ),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Amount", prefixText: "₺"),
        ),
        IconButton(
          onPressed: () {
            _selectDate(context);
          },
          icon: const Icon(Icons.calendar_today),
        ),
        const Text("Select Date"),
        Text(
          'Date: ${DateFormat.yMd().format(_selectedDate)}',
        ),
        const SizedBox(height: 20),
              DropdownButton<Category>(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addNewExpense();
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          );
        }
}