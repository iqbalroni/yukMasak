import 'package:flutter/material.dart';
import 'package:yukmasak/colors.dart';
import 'launcer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "YukMasak",
      debugShowCheckedModeBanner: false,
      home: Launcer(),
    );
  }
}
