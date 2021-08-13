import 'package:flutter/material.dart';
import 'screens/waste_list_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Text('Hello World'));
  }
}