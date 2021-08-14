import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

class WastedFoodForm extends StatefulWidget {
  final File image;

  WastedFoodForm({Key? key, required this.image}) : super(key: key);

  @override
  _WastedFoodFormState createState() => _WastedFoodFormState();
}

class _WastedFoodFormState extends State<WastedFoodForm> {

  final formKey = GlobalKey<FormState>();

  late LocationData locationData;
  late int quantity;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Image(
                  image: FileImage(widget.image),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Number of Wasted Items:',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                  ],
                  onSaved: (value) {
                    quantity = int.parse(value!);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Make sure to enter the number of wasted items!';
                    }
                    return null;
                  }
                ),
              ),   
              Container(
                padding: EdgeInsets.all(10),
                child: Semantics(
                  button: true,
                  enabled: true,
                  onTapHint: 'Upload Post',
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        buttonPressed = true;
                        setState( () {} );
                        uploadPost();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: FutureBuilder<LocationData>(
                          future: getLocation(),
                          builder: (context, snapshot) => uploadButton(context, snapshot),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Future<LocationData> getLocation() async {
    Location location = new Location();
    return await location.getLocation();
  }

  Widget uploadButton(BuildContext context, AsyncSnapshot<LocationData> snapshot) {
    if (snapshot.hasData) {
      locationData = snapshot.data!;
      if (!buttonPressed) {
        return Icon(Icons.add_box, color: Colors.white);
      }
    }
    return Padding(
      padding: EdgeInsets.all(5),
      child: CircularProgressIndicator(),
    );
  }

  String getFilename() {
    int lastSlashIndex = widget.image.path.lastIndexOf('/');
    return widget.image.path.substring(lastSlashIndex);
  }

  void uploadPost() async{
    Reference storageReference = FirebaseStorage.instance.ref().child(
      '${getFilename()} (${new DateTime.now()})'
    );
    UploadTask uploadTask = storageReference.putFile(widget.image);
    await uploadTask;
    String url = await storageReference.getDownloadURL();
    FirebaseFirestore.instance.collection('posts').add({
      'date': Timestamp.fromDate(new DateTime.now()),
      'imageURL': url,
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
      'quantity': quantity,
    });
  }
}