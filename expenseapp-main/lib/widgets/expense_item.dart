import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';


class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                getCategoryIcon(expense.category),
                SizedBox(width: 8), 
                Text(expense.name),
              ],
            ),
            Text(expense.formattedDate),
            Text("${expense.price.toStringAsFixed(2)} ₺"),
          ],
        ),
      ),
    );
  }
}