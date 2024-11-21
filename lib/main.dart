import 'package:advanced_taskapp/views/home/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 45,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 21,
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 234, 234, 234),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Colors.grey,
      fontSize: 17,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey,
      fontSize: 16,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      fontSize: 40,
      color: Colors.black,
      fontWeight: FontWeight.w300,
    ),
  ),
),
      home: const HomeView(),
    );
  }
}