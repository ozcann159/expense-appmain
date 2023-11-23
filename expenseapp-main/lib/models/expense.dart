// identifier => kimlik belirleyici (id)
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, education, travel, work }

class Expense {
  Expense(
      {required this.name,
      required this.price,
      required this.date,
      required this.category})
      : id = uuid.v4();
  // ctor'da bir değeri almak yerine değer atamak

  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Category category;
}
// e31d96a6-f15e-4787-ad2d-9d3965218523, Yemek, 50
// a975e32a-999b-47ac-ae73-929a66dd216c, Yemek, 50
// 28386049-6721-4bcb-adda-061a02020a42, Yemek, 50
// uuid , guid => 
// flutter'a paket ekleme

// Enums
// Enumerated Type

Color getCategoryColor(Category category) {
    switch (category) {
      case Category.food:
        return Color.fromARGB(255, 101, 80, 243);
      case Category.education:
        return Color.fromARGB(255, 208, 92, 247);
      case Category.travel:
        return Color.fromARGB(255, 255, 146, 120);
      case Category.work:
        return Color.fromARGB(255, 66, 204, 201);
      default:
        return Colors.grey;
    }
  }

  Icon getCategoryIcon (Category category) {
    switch (category) {
      case Category.food:
        return Icon(Icons.fastfood, color: getCategoryColor(category));
      case Category.education:
        return Icon(Icons.school, color: getCategoryColor(category));
      case Category.travel:
        return Icon(Icons.flight, color: getCategoryColor(category));
      case Category.work:
        return Icon(Icons.computer, color: getCategoryColor(category));
      default:
        return Icon(Icons.help, color: getCategoryColor(category));
    }

  }
  extension ExpenseExtension on Expense {
   String get formattedDate {
    var formatter = DateFormat.yMd();
    return formatter.format(date);
  }
  
  }
