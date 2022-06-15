import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String userId;
  String email;
  String password;
  String displayName;
  num defaultBreakTime;
  Timestamp? createdTime;
  Timestamp? updatedTime;
  Timestamp? deletedTime;

  Account({
    required this.id, required this.userId, required this.email, required this.password, required this.displayName, required this.defaultBreakTime, this.createdTime, this.updatedTime, this.deletedTime
  });
}
