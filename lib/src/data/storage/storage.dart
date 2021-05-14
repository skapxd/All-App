import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class FirebaseStorage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('/notes.txt');

  Future<void> uploadFile(
    String filePath, {
    VoidCallback onSuccess,
  }) async {
    File file = File(filePath);

    try {
      firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);

      onSuccess();
    } catch (err) {
      // e.g, e.code == 'canceled'
    }
  }
}
