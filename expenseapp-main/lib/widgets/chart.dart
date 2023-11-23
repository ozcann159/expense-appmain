import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expenseapp/models/expense.dart';

class Chart extends StatefulWidget {
  final List<Expense> expenses;

  const Chart({Key? key, required this.expenses}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  Map<Category, double> categoryExpenses = {};

  @override
  void initState() {
    super.initState();
    calculateCategoryExpenses();
  }

  void calculateCategoryExpenses() {
    categoryExpenses.clear();

    widget.expenses.forEach((expense) {
      categoryExpenses.update(
        expense.category,
        (value) => value + expense.price,
        ifAbsent: () => expense.price,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sections: generateSections(),
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 40,
                sectionsSpace: 0,
                centerSpaceColor: Colors.white,
                pieTouchData: PieTouchData(touchCallback: null),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> generateSections() {
    List<PieChartSectionData> sections = [];
    double totalAmount = categoryExpenses.values.reduce((a, b) => a + b);

    categoryExpenses.forEach((category, amount) {
      double percentage = (amount / totalAmount) * 100;
      sections.add(
        PieChartSectionData(
          color: getCategoryColor(category),
          value: amount,
          title: '${percentage.toStringAsFixed(0)}%',
          radius: 50,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        ),
      );
    });

    return sections;
  }
}