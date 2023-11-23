import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/chart.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList(this.expenses, this.onRemove, {Key? key}) : super(key: key);
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;
  

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Expense? _removedExpense;

  void _showUndoSnackbar(Expense removedExpense) {
    final snackBar = SnackBar(
      content: const Text("Expense removed"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            widget.expenses.add(removedExpense);
          });
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey, 
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Chart(expenses: widget.expenses),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(widget.expenses[index]),
                  child: ExpenseItem(widget.expenses[index]),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      // soldan sağa ise
                    }
                    setState(() {
                      _removedExpense = widget.expenses.removeAt(index);
                    });
                    _showUndoSnackbar(_removedExpense!);
                    widget.onRemove(_removedExpense!);
                  },
                  direction: DismissDirection.startToEnd,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}
