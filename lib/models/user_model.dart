import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? role;
  String? uid;
  String? imageUrl;
  String? imagePath;

  UserModel({required this.firstName, required this.lastName, required this.role});
  UserModel.fromDocumentSnapshot(DocumentSnapshot document) {
    firstName = document.get('first_name');
    lastName = document.get('last_name');
    role = document.get('role');
    imageUrl = document.get('image_url');
    imagePath = document.get('image_path');
    uid = document.id;
  }
  UserModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    firstName = document.get('first_name');
    lastName = document.get('last_name');
    role = document.get('role');
    imageUrl = document.get('image_url');
    imagePath = document.get('image_path');
    uid = document.id;
  }

  String get fullName => firstName! + " " + lastName!;
}
