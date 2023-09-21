import 'package:expense_tracker/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

//k in front of variables is used to define global variables especially for color related vars
var kColorTheme = ColorScheme.fromSeed(//we can add these themes to different widgets using themeData
    seedColor: Color.fromARGB(255, 47, 0,
        255)); //this simply sets a color as seed from which the different widgets will take shades of it from
var kDarkColorTheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 26, 22, 44));
void main() async{
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorTheme,
        useMaterial3: true,
        cardTheme: CardTheme().copyWith(
            color: kDarkColorTheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorTheme.secondaryContainer,
                foregroundColor: kDarkColorTheme.onPrimaryContainer))),
    debugShowCheckedModeBanner: false,
    theme: ThemeData().copyWith(
        // scaffoldBackgroundColor: Color.fromARGB(255, 226, 230, 237),
        useMaterial3: true,
        colorScheme: kColorTheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorTheme.onPrimaryContainer,
            foregroundColor: kColorTheme.primaryContainer,
            shadowColor: kColorTheme.background),
        cardTheme: CardTheme().copyWith(
            color: kColorTheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8)), //this will set card theme for our expense_item),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kColorTheme.secondaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
    home: SplashScreen(),
    themeMode: ThemeMode.system,
  ));
}

//here i will be describing the flow of the project
//first we have called expenses widget which is stateful because it will be manipulated in real time
//in expenses widget we have created _registeredExpenses which is dummy data, it is created using expense.dart file which is not a widget but a model for our expenses
//in our model we have created model for our data which contains category, title, spendedAmount
//inside expenses widget we have used expense_list widget which is stateless widget , expense_list simply shows the _registeredExpenses in the form of list of scrollable  page
//expense_list widget simply shows all the registered expense in form of list in single scrollable page
//then expense_list calls expense_item widget for every _registeredExpense.
//expense_item is a stateless widget which shows all the item in the list of expenses in proper manner
