import 'dart:convert';

import 'package:allapp/src/data/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:allapp/src/pages/04_home/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/shared/pref.dart';
import '../../utils/utils.dart';
import 'mapa_page/mapa_page.dart';
import 'tiendas_page/tiendas_page.dart';

class Home extends StatefulWidget {
  static final String pathName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  PageController _pageController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('=====================> $state');

    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        BlocProvider.of<HomeBloc>(context).add(AddPageIndex(1));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();

    accesoGps(
      onGranted: () {
        // _pageController.jumpToPage(state.pageIndex);
      },
    );

    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();

    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    Pref().lastPage = Home.pathName;

    return FutureBuilder(
      future: converGeoLocationToAddress(),
      builder: (BuildContext context, AsyncSnapshot<Welcome> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.plusCode.compoundCode);
        }
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            Future.delayed(Duration.zero, () {
              if (state.pageIndex == 1) {
                accesoGps(
                  onGranted: () {
                    _pageController.jumpToPage(state.pageIndex);
                  },
                );
              } else {
                _pageController.jumpToPage(state.pageIndex);
              }
            });

            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: hexaColor('#232323'),
                unselectedItemColor: Colors.white,
                selectedItemColor: hexaColor('#E6D29F'),
                currentIndex: state.pageIndex,
                onTap: (value) {
                  BlocProvider.of<HomeBloc>(context).add(AddPageIndex(value));
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: SvgPicture.asset(
                        'assets/icons/shop.svg',
                        height: vw * 0.07,
                        color: state.pageIndex == 0
                            ? hexaColor('#E6D29F')
                            : hexaColor('#CCCCCC'),
                      ),
                    ),
                    // title: Text(''),
                    label: 'Tiendas',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: SvgPicture.asset(
                        'assets/icons/map.svg',
                        height: vw * 0.07,
                        color: state.pageIndex == 1
                            ? hexaColor('#E6D29F')
                            : hexaColor('#CCCCCC'),
                      ),
                    ),
                    label: 'Mapa',
                  )
                ],
              ),
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  Tiendas(),
                  MapaPage(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<Welcome> converGeoLocationToAddress() async {
    final latLng = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;

    final latitud = latLng.toString();
    // final longitude = latLng.longitude;

    print(' Latitude and longitude ======> $latitud');

    final googleAPI = Dio(
      BaseOptions(baseUrl: 'https://maps.googleapis.com/maps/api/geocode'),
    );

    // try {
    final respTemp = await googleAPI.get('/json', queryParameters: {
      'key': 'AIzaSyAvrhAPN1yEHRSB_EFLVsfFUJyXe8gMEAs',
      'latlng': '6.0197972,-75.442094'
    });

    final resp = jsonEncode(respTemp.data);

    // print(resp);

    return welcomeFromJson(resp);
    // } catch (e) {
    //   print(e);
    // }
  }
}

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.plusCode,
    this.results,
    this.status,
  });

  PlusCode plusCode;
  List<Result> results;
  String status;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        plusCode: PlusCode.fromJson(json["plus_code"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "plus_code": plusCode.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

class Result {
  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.plusCode,
    this.types,
  });

  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  PlusCode plusCode;
  List<String> types;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(
            json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address_components":
            List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "place_id": placeId,
        "plus_code": plusCode == null ? null : plusCode.toJson(),
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.locationType,
    this.viewport,
    this.bounds,
  });

  Location location;
  String locationType;
  Viewport viewport;
  Viewport bounds;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        locationType: json["location_type"],
        viewport: Viewport.fromJson(json["viewport"]),
        bounds:
            json["bounds"] == null ? null : Viewport.fromJson(json["bounds"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "location_type": locationType,
        "viewport": viewport.toJson(),
        "bounds": bounds == null ? null : bounds.toJson(),
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
