import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';
import 'screens/waste_list_screen.dart';
import 'screens/new_waste_screen.dart';
import 'screens/waste_detail_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: getRoutes(),
        initialRoute: '/'
      );
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => WasteListScreen(),
      'addNew': (context) => NewWasteScreen(),
      'view': (context) => WasteDetailScreen(post: (ModalRoute.of(context)!.settings.arguments) as Post)
    };
  }
}