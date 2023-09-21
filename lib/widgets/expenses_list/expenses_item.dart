import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/expense.dart';

//now the work of ExpensesItem widget is to display items of expenses or _registeredExpenses one by one in proper manner
class ExpensesItem extends StatelessWidget {
  ExpensesItem(this.expense, {super.key});
  Expense
      expense; //this is a variable which stores one of the item of _registeredExpenses

  @override
  Widget build(context) {
    return Card(
      borderOnForeground: true,
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(expense.title,style:  GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 19),),
          const SizedBox(height: 8,),
          Row(
            children: [
              Text(
                  '\$${expense.spendedAmount.toStringAsFixed(2)}', style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w500),), //toStringFixed is used when spended amount is in decimal and max decimal value must be 2
              const Spacer(), //spacer simply takes all the available space between the components
              Row(
                children: [
                  Icon(categoryIcons[expense.category],),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(expense.formattedDate,style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.w700),),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
