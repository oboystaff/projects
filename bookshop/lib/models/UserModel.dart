import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String bioStatus;
  final String displayName;
  final String emailAddress;
  final String profilePicUrl;
  final DateTime creationTime;
  final DateTime lastInfoUpdate;

  User({
    this.creationTime,
    this.uid,
    this.emailAddress,
    this.displayName,
    this.bioStatus,
    this.profilePicUrl,
    this.lastInfoUpdate,
  });

  // formatting for upload to Firbase when creating the new User
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'emailAddress': emailAddress,
      'creationTime': creationTime,
      'profilePicUrl': profilePicUrl,
      'bioStatus': bioStatus,
      'lastInfoUpdate': lastInfoUpdate,
    };
  }

  // creating a User object from a firebase snapshot
  User.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        bioStatus = snapshot['bioStatus'],
        displayName = snapshot['displayName'],
        emailAddress = snapshot['emailAddress'],
        creationTime = snapshot['creationTime'],
        lastInfoUpdate = snapshot['lastInfoUpdate'],
        profilePicUrl = snapshot['profilePicUrl'];
}

// getUsers() async {
//   List<User> users = [];
//   //var req = await http.get("http://my-json-server.typicode.com/OmarYehiaDev/E-Soor/db");
//   var headers = await http
//       .get("https://api.jsonbin.io/b/5e58fd4b1534d9052ce38751", headers: {
//     'Content-Type': 'application/json',
//   });
//   if (headers.statusCode == 200) {
//     print(headers.statusCode);
//     String jsonString = headers.body.toString();
//     print(jsonString);
//     final decodedUsers = convert.jsonDecode(jsonString);
//     decodedUsers.forEach((v) {
//       users.add(User.fromJson(v));
//     });
//     print(users);
//     users.forEach((user) {
//       return user;
//     });
//   } else {
//     print(headers.statusCode);
//   }
// }
