import 'package:flutter/material.dart';

class Komen extends StatefulWidget {
  const Komen({super.key});

  @override
  State<Komen> createState() => _KomenState();
}

class _KomenState extends State<Komen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello World"),
      ),
    );
  }
}
