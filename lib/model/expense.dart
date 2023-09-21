import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid =
    Uuid(); //we are defining it here because it is a utility class, so that we can generate unique ids anywhere

//uuid simply creates a unique string type id for us
enum Category { food, leisure, travel, work, family }

var formatter =
    DateFormat.yMd(); //this will format our date into much beautiful format
const categoryIcons = {
  Category.family: Icons
      .family_restroom, //these are icons which will change according to category
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff
};

class Expense {
  Expense(
      {required this.date,
      required this.spendedAmount,
      required this.title,
      required this.category})
      : id = uuid
            .v4(); //this means whenever the constructor of this class will be called the unique id will be assigned to the id variable
  final String id;
  final double spendedAmount;
  final DateTime date;
  final String title;
  final Category category;

  String get formattedDate {
    //this is a getter function which returns a formatted date which is easy to understand
    return formatter.format(date);
  }
}

class ExpenseBucket {
  //in this we are simply trying to find out the total money spent on a particular category of expense
  ExpenseBucket({required this.category, required this.expensesSum});
  Category category;
  List<Expense> expensesSum;
  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)//this is also a constyructor function of this class
      : expensesSum = allExpense //this will simply add a expense to the list(expensesSum) which have same category
            .where((expense) => expense.category == category)//if category is same then add to the list
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expensesSum) {
      sum += expense.spendedAmount;
    }
    return sum;
  }
}
