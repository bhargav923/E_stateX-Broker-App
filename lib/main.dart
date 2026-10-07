import 'package:flutter/material.dart';

void main() {
  runApp(const MyCustomStop());
}

class MyCustomStop extends StatelessWidget {
  const MyCustomStop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Placeholder(),
    );
  }
}
