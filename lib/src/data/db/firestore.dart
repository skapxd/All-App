import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addUser({
    String phone,
    String token,
    String name,
  }) {
    _firestore.collection('Users').doc('$phone').set({
      'phone': '$phone',
      'token': '$token',
      'name': '$name',
    });
  }

  void addStore({
    String latLng,
    String phoneIdStore,
    Address cityPath,
    // List<String> cityPath,
    String urlImage,
    String telegram,
    String direccion,
    bool visibilidad,
    String phoneCall,
    String nameStore,
    String categories,
    String phoneWhatsApp,
  }) {
    _firestore
        .collection(
          'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store',
        )
        .doc('$phoneIdStore')
        .set({
      'latLng': '$latLng',
      'urlImage': '$urlImage',
      'telegram': '$telegram',
      'direccion': '$direccion',
      'phoneCall': '$phoneCall',
      'nameStore': '$nameStore',
      'visibilidad': visibilidad,
      'phoneWhatsApp': '$phoneWhatsApp',
    }, SetOptions(merge: true));
  }

  void updateStoreRating({
    String message,
    Address cityPath,
    String phoneIdStore,
    String phoneIdClient,
    String dateTiem,
    int numberOfStar,
  }) {
    _firestore.collection('$cityPath/$phoneIdStore').doc('$phoneIdClient').set({
      'message': '$message',
      'dateTime': '$dateTiem',
      'numberOfStar': numberOfStar,
    }, SetOptions(merge: true));
  }

  void updateStoreViewsCounts({
    AddAddress cityPath,
    String phoneIdStore,
  }) {
    _firestore.collection('$cityPath').doc('$phoneIdStore').set({
      'countsViews': FieldValue.increment(1),
    });
  }

  void updateCategoriesViewsCount({
    String categories,
    String cityPath,
  }) {
    _firestore.collection('$cityPath/categories').doc('$categories').set({
      'countsViews': FieldValue.increment(1),
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getListStore({
    Address cityPath,
    String categories,
  }) async {
    final path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

    final store = await _firestore.collection(path).get();

    store.docs.map((e) {
      final f = StoreModel();
    });
  }
}
