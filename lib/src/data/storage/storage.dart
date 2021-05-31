import 'dart:io';

import 'package:allapp/src/models/address_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class FirebaseStorage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('/notes.txt');

  Future<String> uploadLogo({
    String filePath,
    VoidCallback onSuccess,
    @required AddressModel cityPath,
    @required String categories,
    @required phone,
  }) async {
    File file = File(filePath);

    final _path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store/$phone';

    try {
      // firebase_storage.FirebaseStorage.instance
      // .ref('uploads/file-to-upload.png')
      storage.ref(_path).putFile(file);

      final urlDownload = await storage.ref(_path).getDownloadURL();

      onSuccess();

      return urlDownload;
    } catch (err) {
      print('FirebaseStorage - uploadLogo - $err');
      // e.g, e.code == 'canceled'
    }
  }

  // Future<String> getLogo({
  //   String filePath,
  //   VoidCallback onSuccess,
  //   @required AddressModel cityPath,
  //   @required String categories,
  //   @required phone,
  // }) async {
  //   final _path =
  //       'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store/$phone';

  //   return storage.ref(_path).getDownloadURL();
  // }
}
