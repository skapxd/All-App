import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../models/address_model.dart';

class FirebaseStorage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadLogo({
    /// void Function( String cloudPath )
    void Function(String cloudPath) onSuccess,
    String filePath,
    @required String phone,
    @required String categories,
    @required AddressModel cityPath,
  }) async {
    File file = File(filePath);

    final random = Random().nextInt(1000000);

    final randomName = random;

    // final today = DateTime.now();
    print('FirebaseStorage - uploadLogo -  1 randomName: $randomName');

    // final _path =
    //     'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store/$phone/logo';

    final _path = 'country/${cityPath.country}/$phone/logo';

    print('FirebaseStorage - uploadLogo -  2  path: $_path');

    try {
      // firebase_storage.FirebaseStorage.instance
      // .ref('uploads/file-to-upload.png')
      // final e = SettableMetadata(
      //   contentType: '.jpg',
      // );
      storage.ref(_path).putFile(file);

      print('FirebaseStorage - uploadLogo - el logo se subio con exito');

      final getDownloadUrl = await storage.ref(_path).getDownloadURL();
      // final uri = Uri.tryParse(getDownloadUrl);
      // final url = uri.origin + uri.path + '?alt=media';

      onSuccess(getDownloadUrl);
      // onSuccess('url');

      // return urlDownload;
    } catch (err) {
      print('FirebaseStorage - uploadLogo - error: $err');
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

// https://www.google.com/maps/place/5%C2%B056'19.9%22N+76%C2%B022'15.4%22W/@5.9388733,-76.3731267,17z/data=!3m1!4b1!4m9!1m2!2m1!1smap+lat:37.4219784+lng:-122.0840297!3m5!1s0x0:0x0!7e2!8m2!3d5.9388676!4d-76.3709382
