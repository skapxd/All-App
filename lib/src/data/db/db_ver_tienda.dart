import 'package:meta/meta.dart';
import '../../models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBVerTiendas {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> verFotos({
    @required AddressModel cityPath,
    @required String phoneIdStore,
  }) {
    final _path = 'country/${cityPath.country}/store/$phoneIdStore/photos/';

    final fotos = _firestore
        .collection(_path)
        .orderBy('dateTime', descending: true)
        .snapshots();

    return fotos;
  }
}
