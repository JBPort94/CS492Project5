import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_waste_post.dart';
import '../widgets/waste_list_tile.dart';

class WasteList extends StatefulWidget {
  _WasteListState createState() => _WasteListState();
}

class _WasteListState extends State<WasteList> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
              builder: (context, snapshot) => listTileBuilder(context, snapshot),
            ),
          ),
        ]
      )
    );
  }

  Widget listTileBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data.docs.length > 0) {
      return ListView.builder(
        itemCount:snapshot.data.docs.length,
        itemBuilder: (context, index) {
          var postData = snapshot.data.docs[index];
          Post post = createPostFromMap(postData);
          return WasteListTile(post: post);
        }
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Post createPostFromMap(DocumentSnapshot post) {
    return Post(
      date: post['date'].toDate(),
      imageURL: post['imageURL'],
      quantity: post['quantity'],
      latitude: post['latitude'],
      longitude: post['longitude'],
    );
  }
}