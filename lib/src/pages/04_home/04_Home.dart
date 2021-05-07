import 'package:allapp/src/data/shared/pref.dart';
import 'package:allapp/src/utils/Color.dart';
import 'package:allapp/src/widgets/BackgroundGradient.dart';
import 'package:allapp/src/widgets/ruburos/Supermercado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class Home extends StatefulWidget {
  static final String pathName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = new TabController(vsync: this, length: choices.length);
    _tabController = new TabController(length: 12, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  final tabText = [
    Tab(
      icon: Text('Todo'),
    ),
    Tab(
      icon: Text('Supermercado'),
    ),
    Tab(
      icon: Text('Comida rápida'),
    ),
    Tab(
      icon: Text('Drogueria'),
    ),
    Tab(
      icon: Text('Ferreteria'),
    ),
    Tab(
      icon: Text('Restaurantes'),
    ),
    Tab(
      icon: Text('Calzado'),
    ),
    Tab(
      icon: Text('Cosmetiscos'),
    ),
    Tab(
      icon: Text('Electrónicos'),
    ),
    Tab(
      icon: Text('Licor'),
    ),
    Tab(
      icon: Text('Carniceria'),
    ),
    Tab(
      icon: Text('Minimercado'),
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    Pref().lastPage = Home.pathName;

    return Scaffold(
      body: CustomBackgroundGradient(
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              physics: BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverPersistentHeader(
                    floating: true,
                    pinned: false,
                    delegate: _SliverCustomHeaderDelegate(
                      child: Container(
                        color: hexaColor('#232323'),
                        alignment: Alignment.centerLeft,
                        child: AppBar(
                          tabController: _tabController,
                          vw: vw,
                        ),
                      ),
                      minHeight: 60,
                      maxHeight: 60,
                    ),
                  ),
                  SliverPersistentHeader(
                    floating: false,
                    pinned: true,
                    delegate: _SliverCustomHeaderDelegate(
                      minHeight: 51,
                      maxHeight: 51,
                      child: Container(
                        color: hexaColor('#232323'),
                        child: Column(
                          children: [
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: hexaColor('#E6D29F'),
                              unselectedLabelColor: Colors.white,
                              controller: _tabController,
                              indicatorColor: hexaColor('#E6D29F'),
                              indicatorWeight: 4,
                              isScrollable: true,
                              physics: BouncingScrollPhysics(),
                              indicator: MD2Indicator(
                                  //it begins here
                                  indicatorHeight: 4,
                                  indicatorColor: hexaColor('#E6D29F'),
                                  indicatorSize: MD2IndicatorSize
                                      .normal //3 different modes tiny-normal-full
                                  ),
                              tabs: tabText,
                            ),
                            Container(
                              height: 1,
                              color: hexaColor('#E6D29F'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Supermercado(),
                  Text(
                    '2',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '3',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '4',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '5',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '6',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '7',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '8',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '9',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '10',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '11',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                  Text(
                    '12',
                    style: TextStyle(color: hexaColor('#FFFFFF')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key key,
    @required this.vw,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final double vw;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: vw * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: vw * 0.65,
                height: vw * 0.1,
                decoration: BoxDecoration(
                  color: hexaColor('#E6E6E6'),
                  borderRadius: BorderRadius.circular(vw * 1),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: vw * 0.04),
                      child: SvgPicture.asset(
                        'assets/icons/lupa.svg',
                        height: vw * 0.045,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: vw * 0.07),
                      child: Text(
                        'Buscar tiendas',
                        style: TextStyle(
                          color: hexaColor('#939393'),
                          fontSize: vw * 0.04,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: hexaColor('#E6E6E6'),
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text(
                  Pref().phone.split('')[12],
                  style: TextStyle(
                    color: hexaColor('#383838'),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // TODO: implement build
    return SizedBox.expand(
      child: this.child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => this.maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => this.minHeight;

  @override
  bool shouldRebuild(covariant _SliverCustomHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return this.maxHeight != oldDelegate.maxHeight ||
        this.minHeight != oldDelegate.minHeight ||
        this.child != oldDelegate.child;
  }
}
