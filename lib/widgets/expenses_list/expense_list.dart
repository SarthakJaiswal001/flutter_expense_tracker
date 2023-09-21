import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense>
      expenses; //here the ExpensesList will receive _registeredExpenses as argument and expenses is equal to _registeredExpenses and it is also a list of Expenses
  void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(context) {
    return ListView.builder(
        //now here ListView.builder will all the items in list of expenses which is expenses variable one by one
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Dismissible(
            //this helps us in removing the expense item by swiping
            key: ValueKey(expenses[index]), //this is compulsory parameter
            background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal
            ),),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpensesItem(expenses[index]),
          ); //all the items in expenses(list of Expense) will be passed to ExpensesItem widget one by one
        });
  }
}
