class Post {

  late DateTime date;
  late String imageURL;
  late int quantity;
  late double latitude;
  late double longitude;

  Post({ required this.date, 
          required this.imageURL, 
          required this.quantity, 
          required this.latitude, 
          required this.longitude });

  Post.fromMap(Map map) {
    this.date = map['date'];
    this.imageURL = map['imageURL'];
    this.quantity = map['quantity'];
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
  }
}