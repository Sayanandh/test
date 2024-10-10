import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp()); // No 'const' here since MyApp is not a const constructor
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Use super.key for cleaner code

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // This is okay as long as HomeScreen is a const constructor
    );
  }
}
