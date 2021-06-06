import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/address_model.dart';
import '../../models/cache_store_model.dart';
// import '../../models/store_model.dart';
import '../bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../shared/pref.dart';

class DBFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _pref = Pref();

  int count = 0;

  final now = DateTime.now();

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
    final _path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

    print('DBFirestore - _path: $_path');
    print('DBFirestore - phoneIdStore: $phoneIdStore');

    _firestore.collection(_path).doc('$phoneIdStore').set({
      'latLng': '${latLng ?? ''}',
      'urlImage': '${urlImage ?? ''}',
      'telegram': '${telegram ?? ''}',
      'direccion': '${direccion ?? ''}',
      'phoneCall': '${phoneCall ?? ''}',
      'nameStore': '${nameStore ?? ''}',
      'visibilidad': visibilidad ?? false,
      'phoneWhatsApp': '${phoneWhatsApp ?? ''}',
    }, SetOptions(merge: true));
  }

  void removeStore({
    @required AddressModel cityPath,
    @required String categories,
    @required String phoneIdStore,
  }) {
    final _path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

    _firestore.collection(_path).doc('$phoneIdStore').delete();
  }

  void updateStoreIcon({
    @required AddressModel cityPath,
    @required String categories,
    @required String phoneIdStore,
    @required String urlImage,
  }) {
    //

    final _path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

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

  Future<List<StoreModel>> getListStore({
    @required AddressModel cityPath,
    @required String categories,
  }) async {
    //

    // final path =
    //     '/country/colombia/departament/antioquia/city/la_ceja/categories/todo/store';

    final now = DateTime.now();

    final path =
        'country/${cityPath.country}/departament/${cityPath.department}/city/${cityPath.city}/categories/$categories/store';

    CacheStoreModel cache;

    try {
      // cache = cacheStoreModelFromJson(_pref.cacheStore);

      final cacheTemp = _pref.getAnyData(path: path);

      cache = cacheStoreModelFromJson(cacheTemp);
    } catch (e) {
      cache = null;
    }

    // Si el cache no existe lo crea y lo guarda
    if (cache == null) {
      //

      print('cache es null');

      return _listStoreModel(path: path);
    }

    final expire = DateTime.parse(cache.expire);

    // Si el cache existe pero esta vencido
    if (expire.isBefore(now)) {
      //
      print('cache no es nulo pero expiro ${cache.storeModel[0].nameStore}');

      return _listStoreModel(path: path);
    }

    print('cache vigente');

    final data = _pref.getAnyData(path: path);

    try {
      final cache2 = cacheStoreModelFromJson(data);

      return cache2.storeModel;
    } catch (e) {
      //

      print('Firestore - getListStore - Error: $e');
    }
  }

  Future<List<StoreModel>> _listStoreModel({
    @required String path,
  }) async {
    final store = await getDataOfFireStore(path: path);

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

  Future<QuerySnapshot<Map<String, dynamic>>> getDataOfFireStore({
    @required String path,
  }) async {
    print('Veces que se ha hecho una peticion a FireStore');

    return _firestore.collection(path).get();
  }
}
