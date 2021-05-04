// import 'package:allapp/src/data/shared/pref.dart';
// import 'package:allapp/src/utils/Color.dart';
// import 'package:allapp/src/widgets/BackgroundGradient.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Home extends StatefulWidget {
//   static final String pathName = '/Home';

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> with TickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     // _tabController = new TabController(vsync: this, length: choices.length);
//     _tabController = new TabController(length: 3, vsync: this);

//     _tabController.addListener(() {
//       print(_tabController.index);
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // View Width
//     final double vw = MediaQuery.of(context).size.width;
//     // View Height
//     final double vh = MediaQuery.of(context).size.height;

//     Pref().lastPage = Home.pathName;

//     return Scaffold(
//       body: CustomBackgroundGradient(
//         child: SafeArea(
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: vw * 0.05),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: vw * 0.65,
//                       height: vw * 0.1,
//                       decoration: BoxDecoration(
//                         color: hexaColor('#E6E6E6'),
//                         borderRadius: BorderRadius.circular(vw * 1),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: vw * 0.04),
//                             child: SvgPicture.asset(
//                               'assets/icons/burger.svg',
//                               height: vw * 0.045,
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: vw * 0.07),
//                             child: Text(
//                               'Buscar tiendas',
//                               style: TextStyle(
//                                 color: hexaColor('#939393'),
//                                 fontSize: vw * 0.04,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     CircleAvatar(
//                       backgroundColor: hexaColor('#E6E6E6'),
//                       child: Text(
//                         Pref().phone.split('')[12],
//                         style: TextStyle(
//                           color: hexaColor('#383838'),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   TabBar(
//                     controller: _tabController,
//                     indicatorColor: hexaColor('#E6D29F'),
//                     indicatorWeight: 4,
//                     tabs: [
//                       Tab(
//                         icon: Icon(Icons.ac_unit),
//                       ),
//                       Tab(
//                         icon: Icon(Icons.ac_unit),
//                       ),
//                       Tab(
//                         icon: Icon(Icons.ac_unit),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 1,
//                     color: hexaColor('#E6D29F'),
//                   ),
//                   TabBarView(
//                     controller: _tabController,
//                     children: [
//                       Text('1'),
//                       Text('2'),
//                       Text('3'),
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class Home extends StatefulWidget {
  static final String pathName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Widget> _tabs = [
    Center(child: Text('You have selected the car !!!')),
    Center(child: Text('Do you like train?'))
  ];

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      print(_controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('widget.title'),
      //   bottom: TabBar(
      //     tabs: [
      //       Tab(icon: Icon(Icons.directions_car)),
      //       Tab(icon: Icon(Icons.directions_transit)),
      //     ],
      //     onTap: (index) {
      //       print(index);
      //     },
      //     controller: _controller,
      //   ),
      // ),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
            onTap: (index) {
              print(index);
            },
            controller: _controller,
          ),
          Center(
            child: TabBarView(
              children: _tabs,
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
