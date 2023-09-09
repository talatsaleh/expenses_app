import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final formatterDate = DateFormat.yMd();

enum Category {
  food,
  transport,
  cloth,
  leisure,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.emoji_transportation,
  Category.leisure: Icons.movie,
  Category.cloth: Icons.shopping_bag,
};

class Expenses {
  Expenses(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = _uuid.v4();
  String id;
  String title;
  double amount;
  DateTime date;
  Category category;

  String get getFormattedDate {
    return formatterDate.format(date);
  }
}
