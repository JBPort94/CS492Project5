import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/food_waste_post.dart';

class WasteDetailScreen extends StatelessWidget {

  Post post;
  DateFormat dateFormat = DateFormat('EEEE, LLL. d yyyy');

  WasteDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    post = (ModalRoute.of(context)!.settings.arguments) as Post;
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              Column(
                children: [
                  dateRow(),
                  imageRow(),
                  quantityRow(),
                  locationRow()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dateRow(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          dateFormat.format(post.date),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget imageRow(){
    return Container(
      padding: EdgeInsets.all(10),
      child: CachedNetworkImage(
        imageUrl: post.imageURL,
        placeholder: (context, url) => Padding(
          padding: EdgeInsets.all(10),
          child: CircularProgressIndicator()
        ),
      ),
    );
  }

  Widget quantityRow(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          'Items Wasted: ${post.quantity}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget locationRow(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          'Location: ${post.latitude}, ${post.longitude}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}