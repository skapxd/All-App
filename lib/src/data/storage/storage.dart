import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../models/address_model.dart';

class FirebaseStorage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('/notes.txt');

  Future<void> uploadLogo({
    /// void Function( String cloudPath )
    void Function(String cloudPath) onSuccess,
    String filePath,
    @required String phone,
    @required String categories,
    @required AddressModel cityPath,
  }) async {
    File file = File(filePath);

    final _path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store/$phone';

    try {
      // firebase_storage.FirebaseStorage.instance
      // .ref('uploads/file-to-upload.png')
      final e = SettableMetadata(contentType: '.jpg');
      storage.ref(_path).putFile(file, e);

      // final urlDownload = await storage.ref(_path).getMetadata();
      final getDownloadUrl = await storage.ref(_path).getDownloadURL();
      // print('FirebaseStorage - urlDownload: ${urlDownload.fullPath}');
      final uri = Uri.tryParse(getDownloadUrl);
      final url = uri.origin + uri.path + '?alt=media';
      // final urlfinal = url

      // print('FirebaseStorage - uri: $url');

      onSuccess(url);

      // return urlDownload;
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
