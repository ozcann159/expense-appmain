import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/pages/expense_list.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:expenseapp/theme/provider_theme.dart';

enum ThemeDataStyle {
  light,
  dark,
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  
  State<StatefulWidget> createState() => _MainPageState();
  
}

class _MainPageState extends State<MainPage> {


  final List<Expense> expenses = [
    Expense(name: "Yiyecek", price: 200, date: DateTime.now(), category: Category.food),
    Expense(name: "Flutter Udemy Course", price: 200, date: DateTime.now(), category: Category.education),
  ];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseApp'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF6550F3),
                Color(0xFFD05CD7),
              ],
            ),
          ),
        ),
        actions: [
       Switch(
            value: themeProvider.themeDataStyle == ThemeDataStyle.dark ? true : false,
            onChanged: (isOn) {
              themeProvider.changeTheme();
            },
          ),
      ],
    
      ),
      body: Stack(
        children: [
          ExpenseList(expenses, removeExpense),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF6550F3), Color(0xFFD05CD7)],
                ),
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => NewExpense(
                      onAdd: (expense) => addExpense(expense),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//chart hesaplaması ekle