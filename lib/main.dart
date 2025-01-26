import 'package:flutter/material.dart';
import 'package:shoe_shop/cart_provider.dart';
import 'package:shoe_shop/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
          title: "shoe store",
          theme: ThemeData(
            fontFamily: "Quicksand",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            useMaterial3: true,
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              bodySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          home: const HomePage()),
    );
  }
}
