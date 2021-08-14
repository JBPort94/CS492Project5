import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/food_waste_post.dart';

DateFormat dateFormat = DateFormat('EEEE, LLL. d');

class WasteListTile extends StatelessWidget {

  Post post;

  WasteListTile({Key ?key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onTapHint: 'View Post# ${post.date}',
      child: ListTile(
        title: Text(
          dateFormat.format(post.date),
          style: TextStyle(fontSize: 22),
        ),
        trailing: Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(13),
            child: Text(
              post.quantity.toString(),
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('view', arguments: post);
        },
      ),
    );
  }
}