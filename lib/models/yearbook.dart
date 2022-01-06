import 'package:cloud_firestore/cloud_firestore.dart';

class Yearbook {
  String? uid;
  String? title;
  String? school_year;
  String? prayer;
  String? song;
  String? yearbookUrl;
  bool? published;
  List<dynamic>? students;
  List<dynamic>? teachers;

  Yearbook({required this.title, required this.school_year, required this.published});

  Yearbook.fromQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    uid = document.id;
    title = document.get('title');
    school_year = document.get('school_year');
    published = document.get('published');
    prayer = document.get('prayer');
    song = document.get('song');
    students = document.get('students');
    teachers = document.get('teachers');
    yearbookUrl = document.get('yearbook_url');
  }

  Yearbook.fromDocumentSnapshot(DocumentSnapshot document) {
    uid = document.id;
    title = document.get('title');
    school_year = document.get('school_year');
    published = document.get('published');
    prayer = document.get('prayer');
    song = document.get('song');
    students = document.get('students');
    teachers = document.get('teachers');
    yearbookUrl = document.get('yearbook_url');
  }
}
