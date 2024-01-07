import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(UniversityApp());

class UniversityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UniversityHomePage(),
    );
  }
}
