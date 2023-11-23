import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenseapp/pages/main_page.dart';
import 'package:expenseapp/theme/provider_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeDataStyle,
      home: const MainPage(),
    );
  }
}
