import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String authorID;
  final String authorName;
  final String displayName;
  final String price;
  final String picUrl;
  final DateTime creationTime;
  final DateTime lastInfoUpdate;
  final String category;
  final String categoryID;
  Book({
    this.category,
    this.categoryID,
    this.authorName,
    this.creationTime,
    this.lastInfoUpdate,
    this.id,
    this.authorID,
    this.displayName,
    this.price,
    this.picUrl,
  });

  // formatting for upload to Firbase when creating the new Book
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'authorID': authorID,
      'authorName': authorName,
      'price': price,
      'picUrl': picUrl,
      'category': category,
      'categoryID': categoryID,
      'creationTime': creationTime,
      'lastInfoUpdate': lastInfoUpdate,
    };
  }

  // creating a Book object from a firebase snapshot
  Book.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        displayName = snapshot['displayName'],
        authorID = snapshot['authorID'],
        authorName = snapshot['authorName'],
        price = snapshot['price'],
        picUrl = snapshot['picUrl'],
        category = snapshot['category'],
        categoryID = snapshot['categoryID'],
        creationTime = snapshot['creationTime'],
        lastInfoUpdate = snapshot['lastInfoUpdate'];
}

/*

1- Pic
2- Author
3- Average Rating
4- Name
5- Price
6- Category
7- Feedbacks
8- Your feedback (if isn’t null)
9- SubCategory (if isn’t null)


 */
