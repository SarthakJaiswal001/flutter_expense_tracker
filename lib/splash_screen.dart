import 'dart:async';

import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Expenses();
      }));
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 16, 9, 220),
          Color.fromARGB(255, 2, 85, 152),
          Color.fromARGB(255, 6, 100, 163),
          Color.fromARGB(255, 22, 77, 172)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child:  Center(
          child: Text(
            'Expense Tracking Made Simple.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inclusiveSans(
              
                color: const Color.fromARGB(255, 247, 243, 243), fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
