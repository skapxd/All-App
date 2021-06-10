import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meta/meta.dart';

import '../../models/address_model.dart';

class DBFirebaseStorage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadLogo({
    void Function(String cloudPath) onSuccess,
    String filePath,
    @required String phone,
    @required String categories,
    @required AddressModel cityPath,
  }) async {
    //

    File file = File(filePath);

    final _path = 'country/${cityPath.country}/$phone/logo';

    try {
      //

      storage.ref(_path).putFile(file);

      print('DBFirebaseStorage - uploadLogo - el logo se subio con exito');

      final getDownloadUrl = await storage.ref(_path).getDownloadURL();

      onSuccess(getDownloadUrl);
    } catch (err) {
      print('DBFirebaseStorage - uploadLogo - error: $err');
    }
  }

  Future<void> uploadImageProduct({
    @required String filePath,
    @required String phone,
    @required AddressModel cityPath,
    void Function(String cloudPath) onSuccess,
  }) async {
    //

    // No hay imagen porque es una modificacion del producto
    if (filePath == null) {
      return onSuccess(null);
    }

    File file = File(filePath);

    final random = Random();

    final productName = random.nextInt(10000000);

    final _path = 'country/${cityPath.country}/$phone/products/$productName';

    try {
      //

      // Hay imagen porque es la creacion de un producto
      final uploadTask = await storage.ref(_path).putFile(file);

      print(
        'DBFirebaseStorage - uploadImageProduct - el producto se subio con exito',
      );

      uploadTask.ref.getDownloadURL().then((value) => onSuccess(value));

      // storage.ref(_path).getDownloadURL().then((value) => onSuccess(value));
    } catch (err) {
      print('DBFirebaseStorage - uploadLogo - error: $err');
    }
  }

  Future<void> uploadImageStore({
    @required String phone,
    @required String filePath,
    @required AddressModel cityPath,
    void Function(String cloudUrl) onSuccess,
  }) async {
    //

    File file = File(filePath);

    final random = Random();

    final productName = random.nextInt(10000000);

    final _path = 'country/${cityPath.country}/$phone/imges-store/$productName';

    try {
      //

      final uploadTask = await storage.ref(_path).putFile(file);

      print(
        'DBFirebaseStorage - uploadImageStore - el producto se subio con exito',
      );

      uploadTask.ref.getDownloadURL().then((value) => onSuccess(value));
    } catch (e) {
      print(
        'DBFirebaseStorage - uploadImageStore - error: $e',
      );
    }
  }
}
