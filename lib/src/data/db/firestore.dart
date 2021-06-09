import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/address_model.dart';
import '../../models/cache_store_model.dart';
import '../shared/pref.dart';

class DBFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _pref = Pref();

  int count = 0;

  final now = DateTime.now();

  Future<List> getCategory({
    @required String categories,
  }) async {
    //

    final _path = 'categories';

    final data = await _firestore.collection(_path).doc('$categories').get();

    print('DBFirestore - getCategory - data ${data.data()}');

    final listCategories = data.data()['names'] as List;

    print('DBFirestore - getCategory - listCategories $listCategories');

    return listCategories;
  }

  void addFuture({
    @required String phoneIdStore,
    @required AddressModel cityPath,
  }) {
    _firestore
        .collection('Users')
        .doc('$phoneIdStore')
        .set({}, SetOptions(merge: true));
  }

  void addMyCategori({
    @required String phoneIdStore,
    @required AddressModel cityPath,
    @required String categories,
  }) {
    //

    final _path = 'country/${cityPath.country}/store/$phoneIdStore/categories/';

    _firestore
        .collection(_path)
        .doc('$categories')
        .set({}, SetOptions(merge: true));
  }

  void deleteMyCategori({
    @required String phoneIdStore,
    @required AddressModel cityPath,
    @required String categories,
  }) async {
    final _path = 'country/${cityPath.country}/store/$phoneIdStore/categories/';

    _firestore.collection(_path).doc('$categories').delete();
  }

  void addProducInMyCategori({
    String urlImageProducto,
    @required String idProduct,
    @required String categories,
    @required String productQty,
    @required String productName,
    @required String phoneIdStore,
    @required String productPrice,
    @required AddressModel cityPath,
    @required bool productAvailability,
  }) {
    //

    final _path =
        'country/${cityPath.country}/store/$phoneIdStore/categories/$categories/product/';

    Map<String, dynamic> dataUpload = {};

    if (urlImageProducto != null) {
      dataUpload.addAll({
        "urlImageProducto": urlImageProducto,
      });
    }

    if (productAvailability != null) {
      // dataUpload["disponibilidad"] = productAvailability;
      dataUpload.addAll({
        "disponibilidad": productAvailability,
      });
    }

    if (productName != null) {
      // dataUpload["nombre"] = productName;
      dataUpload.addAll({
        "nombre": productName,
      });
    }

    if (productPrice != null) {
      // dataUpload["precio"] = productPrice;
      dataUpload.addAll({
        "precio": productPrice,
      });
    }

    if (productQty != null) {
      // dataUpload["cantidad"] = productQty;
      dataUpload.addAll({
        "cantidad": productQty,
      });
    }

    print('DBFirestore - addProducInMyCategori - data: $dataUpload');

    try {
      _firestore.collection(_path).doc(idProduct).set(
            dataUpload,
            SetOptions(merge: true),
          );
    } catch (e) {
      print('DBFirestore - addProducInMyCategori - error: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducInMyCategori({
    @required String phoneIdStore,
    @required AddressModel cityPath,
    @required String categories,
  }) {
    //

    final _path =
        'country/${cityPath.country}/store/$phoneIdStore/categories/$categories/product/';

    final stream = _firestore.collection(_path).snapshots();

    return stream;
  }

  void deleteProducInMyCategori({
    @required String phoneIdStore,
    @required AddressModel cityPath,
    @required String categories,
    @required String productName,
  }) {
    //

    final _path =
        'country/${cityPath.country}/store/$phoneIdStore/categories/$categories/product/';

    _firestore.collection(_path).doc(productName).delete();

    // return stream;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyCategori({
    @required String phoneIdStore,
    @required AddressModel cityPath,
  }) {
    final _path = 'country/${cityPath.country}/store/$phoneIdStore/categories/';

    final stream = _firestore
        .collection(
          _path,
        )
        .snapshots();

    return stream;
  }

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
    @required AddressModel cityPath,
    @required String categories,
    @required bool visibilidad,
    @required String latLng,
    @required String phoneIdStore,
    @required String urlImage,
    @required String telegram,
    @required String direccion,
    @required String phoneCall,
    @required String nameStore,
    @required String phoneWhatsApp,
  }) {
    //

    // final _path =
    //     'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

    final _path = 'country/${cityPath.country}/store';

    print('DBFirestore - _path: $_path');
    print('DBFirestore - phoneIdStore: $phoneIdStore');

    _firestore.collection(_path).doc('$phoneIdStore').set({
      'city': '${cityPath.city}',
      'country': '${cityPath.country}',
      'categories': categories,
      'latLng': '${latLng ?? ''}',
      'urlImage': '${urlImage ?? ''}',
      'telegram': '${telegram ?? ''}',
      'direccion': '${direccion ?? ''}',
      'phoneCall': '${phoneCall ?? ''}',
      'nameStore': '${nameStore ?? ''}',
      'visibilidad': visibilidad ?? false,
      'departament': '${cityPath.department}',
      'phoneWhatsApp': '${phoneWhatsApp ?? ''}',
    }, SetOptions(merge: true));
  }

  void removeStore({
    @required AddressModel cityPath,
    @required String categories,
    @required String phoneIdStore,
  }) {
    //   final _path =
    //       'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

    final _path = 'country/${cityPath.country}/store';

    _firestore.collection(_path).doc('$phoneIdStore').delete();
  }

  void updateStoreIcon({
    @required AddressModel cityPath,
    @required String categories,
    @required String phoneIdStore,
    @required String urlImage,
  }) {
    //

    final _path = 'country/${cityPath.country}/store';

    _firestore.collection(_path).doc('$phoneIdStore').set({
      'urlImage': '${urlImage ?? ''}',
    }, SetOptions(merge: true));
  }

  void updateStoreRating({
    String message,
    AddressModel cityPath,
    String phoneIdStore,
    String phoneIdClient,
    String dateTiem,
    int numberOfStar,
  }) {
    final _path = 'country/${cityPath.country}/store';

    _firestore.collection(_path).doc('$phoneIdClient').set({
      'message': '$message',
      'dateTime': '$dateTiem',
      'numberOfStar': numberOfStar,
    }, SetOptions(merge: true));
  }

  void updateStoreViewsCounts({
    AddressModel cityPath,
    String phoneIdStore,
  }) {
    final _path = 'country/${cityPath.country}/store';

    _firestore.collection(_path).doc('$phoneIdStore').set({
      'countsViews': FieldValue.increment(1),
    });
  }

  void updateCategoriesViewsCount({
    String categories,
    AddressModel cityPath,
  }) {
    final _path = 'country/${cityPath.country}/store';

    _firestore.collection(_path).doc('$categories').set({
      'countsViews': FieldValue.increment(1),
    });
  }

  Future<List<StoreModel>> getListCategoriesStore({
    @required AddressModel cityPath,
    @required String categories,
  }) async {
    //

    final now = DateTime.now();

    final path = 'country/${cityPath.country}/store';

    CacheStoreModel cache;

    print('DBFirestore - getListCategoriesStore - path: $path');

    try {
      //

      final cacheTemp = _pref.getAnyData(path: path);

      cache = cacheStoreModelFromJson(cacheTemp);
    } catch (e) {
      cache = null;
    }

    // Si el cache no existe lo crea y lo guarda
    if (cache == null) {
      //

      print('DBFirestore - getListCategoriesStore - cache es null');

      return _listStoreModel(
        path: path,
        categories: categories,
        cityPath: cityPath,
      );
    }

    final expire = DateTime.parse(cache.expire);

    print(
        'DBFirestore - getListCategoriesStore - cache.expire: ${cache.expire}');

    // Si el cache existe pero esta vencido
    if (expire.isBefore(now)) {
      //

      // print('etc');
      print(
        'DBFirestore - getListCategoriesStore - cache no es nulo pero expiro ${cache.expire}',
      );

      return _listStoreModel(
        path: path,
        categories: categories,
        cityPath: cityPath,
      );
    }

    print('DBFirestore - getListCategoriesStore - cache vigente');

    final data = _pref.getAnyData(path: path);

    try {
      final cache2 = cacheStoreModelFromJson(data);

      return cache2.storeModel;
    } catch (e) {
      //

      print('Firestore - getListCategoriesStore - Error: $e');
    }
  }

  Future<List<StoreModel>> _listStoreModel({
    @required String path,
    @required AddressModel cityPath,
    @required String categories,
  }) async {
    //

    QuerySnapshot<Map<String, dynamic>> store;

    if (categories != 'todo') {
      //

      store = await getDataFilterStoreOfFireStore(
        categories: categories,
        cityPath: cityPath,
      );
    } else {
      //

      store = await getDataAllCategoriesStoreOfFireStore(
        categories: categories,
        cityPath: cityPath,
      );
    }

    final List<StoreModel> listStoremodel =
        store.docs.map((queryDocumentSnapshot) {
      //

      final _storeModelTemp = StoreModel(
        latLng: queryDocumentSnapshot['latLng'],
        urlImage: queryDocumentSnapshot['urlImage'],
        telegram: queryDocumentSnapshot['telegram'],
        nameStore: queryDocumentSnapshot['nameStore'],
        phoneCall: queryDocumentSnapshot['phoneCall'],
        direccion: queryDocumentSnapshot['direccion'],
        visibilidad: queryDocumentSnapshot['visibilidad'],
        phoneWhatsApp: queryDocumentSnapshot['phoneWhatsApp'],
      );

      return _storeModelTemp;
    }).toList();

    print('DBFirestore - listStoremodel: ${listStoremodel.length}');

    final expire = DateTime(
            now.year, now.month, now.day, now.hour, (now.minute))
        // DateTime(now.year, now.month, now.day, now.hour, (now.minute + 30))
        .toString();

    final cacheTemp = CacheStoreModel(
      expire: expire,
      path: path,
      storeModel: listStoremodel,
    );

    _pref.cacheStore = cacheTemp;

    //////////////////////////////////////////////

    final data = _pref.getAnyData(path: path);

    try {
      final cache2 = cacheStoreModelFromJson(data);

      return cache2.storeModel;
    } catch (e) {
      print('Firestore - _listStoreModel - Error: $e');
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataFilterStoreOfFireStore({
    @required AddressModel cityPath,
    @required String categories,
  }) async {
    print(
      'DBFirestore - getDataOfFireStore - Veces que se ha hecho una peticion a FireStore',
    );

    final data = await _firestore
        .collection('country/${cityPath.country}/store')
        .where(
          'country',
          isEqualTo: '${cityPath.country}',
        )
        .where(
          'departament',
          isEqualTo: '${cityPath.department}',
        )
        .where(
          'city',
          isEqualTo: '${cityPath.city}',
        )
        .where(
          'categories',
          isEqualTo: '$categories',
        )
        .get();

    print('DBFirestore - getDataFilterStoreOfFireStore - data: ${data.docs}');

    // print('Firestore - getDataOfFireStore - path: $path');

    return data;
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getDataAllCategoriesStoreOfFireStore({
    @required AddressModel cityPath,
    @required String categories,
  }) async {
    print(
      'DBFirestore - getDataOfFireStore - Veces que se ha hecho una peticion a FireStore',
    );

    final data = await _firestore
        .collection('country/${cityPath.country}/store')
        .where(
          'country',
          isEqualTo: '${cityPath.country}',
        )
        .where(
          'departament',
          isEqualTo: '${cityPath.department}',
        )
        .where(
          'city',
          isEqualTo: '${cityPath.city}',
        )
        .get();

    print(
      'DBFirestore - getDataAllCategoriesStoreOfFireStore - data: ${data.docs}',
    );

    // print('Firestore - getDataOfFireStore - path: $path');

    return data;
  }
}
