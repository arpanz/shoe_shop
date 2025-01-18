import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "shoe store",
        theme: ThemeData(
            fontFamily: "Quicksand",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            inputDecorationTheme: InputDecorationTheme(
                hintStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        home: HomePage());
  }
}
