// data model
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// intl bta3mela format lal Date
final formatter = DateFormat.yMd();

const uuid = Uuid();

// this is basically to generalize a7san to reduce error
enum Category {
  food,
  travel,
  leisure,
  work,
}

// ignore: constant_identifier_names
const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    // hayde initializer list, metel bas 3ayet lala constructor 7a ta3mele assign lal id
  }) : id = uuid.v4();

  // i will use a package called uuid to generate unique id's
  final String id;
  final String title;
  final double amount;
  // special data type to store date info in a single value
  final DateTime date;
  final Category category;

  String get formatedDate {
    // returns a String
    return formatter.format(date);
  }
}
