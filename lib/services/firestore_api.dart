import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
class FirestoreApi {

  static firebase_storage.UploadTask? uploadVideo(List category, File image, String title) {
    try {
      final videoRef = storage.ref('video');
      return videoRef.child(title).putFile(image);
    } on firebase_storage.FirebaseException {
      return null;
    }
  }

  static firebase_storage.UploadTask? uploadArticle(List category, File image,
      String title, String headline, String description) {
    try {
      final articleRef = storage.ref('article');
      return articleRef.child(title).putFile(image);
    } on firebase_storage.FirebaseException {
      return null;
    }
  }
}
