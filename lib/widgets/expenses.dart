import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        //this is the modal which contains the modal for our data, this is just a class neither stateful nor stateless
        //this is just some dummy data that we have provided already
        date: DateTime.now(),
        spendedAmount: 12,
        title: 'Movie',
        category: Category.leisure),
    Expense(
        date: DateTime.now(),
        spendedAmount: 10,
        title: 'House',
        category: Category.family)
  ];

  void modalonpress() {
    //when this function will be called on pressing the add button , it will call showModalBottomSheet widget which will further call NewExpense widget, in NewExpense Widget we have passed addExpense as argument
    showModalBottomSheet(
        isScrollControlled: true, //this will take full screen
        context: context,
        builder: (ctx) {
          return NewExpense(
            onaddExpense: addExpense,
          );
        });
  }

  void addExpense(Expense expense) {
    setState(() {
      //this function simply adds new expense on _registeredExpenses , setState() is used because it will also change ui after adding new expense
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);//here we are storing the index value of expense,which will be removed, it will help us in undo
    //this function will remove expense item from _registeredExpense
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(//this is snackbar which will be showed in bottom of screen when a expense will be removed
      content: Text('Expense Removed'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(context) {


    Widget mainContent = Center(//this will be showed when there is no expense present in registered expense
      child: Text('No Expense to show, add some Expenses'),
    );
    if (_registeredExpenses.isNotEmpty) {//if not empty
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker',style: GoogleFonts.roboto(fontSize: 25),),
        actions: [
          IconButton(
            //this add button will open a modalbottomsheet which will provide us option to add new expense
            onPressed: modalonpress,
            //on clicking the add icon this function will be called
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Center(
              child: Text(
                ' Your Expenses',
                style: GoogleFonts.mooli(fontWeight: FontWeight.w700, fontSize: 25,color: Color.fromARGB(255, 16, 34, 86)),
              ),
            ),
            Expanded(

              child:
                  mainContent, //here the body will call expense_list in which we have passed _registeredExpenses as argument, _registeredExpenses is a list of Expenses
            )
          ],
        ),
      ),
    );
  }
}
