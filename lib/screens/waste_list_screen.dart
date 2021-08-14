import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/waste_list.dart';

class WasteListScreen extends StatefulWidget {
  _WasteListScreenState createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) => setTitleQuant(context, snapshot),
        ),
        centerTitle: true
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: WasteList(),
        ),
      ),
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Add New Post',
        child: ElevatedButton(
            child: Icon(Icons.add_a_photo),
            onPressed: () {
              getImage();
            },
          ),
      )
    );
  }

  Widget setTitleQuant(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data.docs.length > 0) {
      int totalCount = 0;
      snapshot.data.docs.forEach((post) {
        totalCount += (post['quantity']) as int;
      });
      return Text('Wasteagram: $totalCount');
    }
    return Text('Wasteagram - 0');
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    File? image = File(pickedFile!.path);
    Navigator.of(context).pushNamed('addNew', arguments: image);
  }

}