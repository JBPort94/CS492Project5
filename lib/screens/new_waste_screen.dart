import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/wasted_food_form.dart';

class NewWasteScreen extends StatelessWidget {

  late File image;

  @override
  Widget build(BuildContext context) {
    image = (ModalRoute.of(context)!.settings.arguments) as File;
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram - Add New'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: WastedFoodForm(image: image),
        ),
      ),
    );
  }
}