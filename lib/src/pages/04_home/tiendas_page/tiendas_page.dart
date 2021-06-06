import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import '../../../data/shared/pref.dart';
import '../../../utils/utils.dart';
import '../../../widgets/BackgroundGradient.dart';
import '../../../widgets/Menu/Menu.dart';
import '../../../widgets/ruburos/tipo_de_comercio.dart';
import '../bloc/home_bloc.dart';

class Tiendas extends StatefulWidget {
  @override
  _TiendasState createState() => _TiendasState();
}

class _TiendasState extends State<Tiendas>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

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
  void initState() {
    super.initState();
    _tabController = new TabController(length: 12, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //

    final homeBloc = BlocProvider.of<HomeBloc>(context);

    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return CustomBackgroundGradient(
      child: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            BuscadorYPerfil(
              tabController: _tabController,
            ),
            CustomTapBar(
              tabController: _tabController,
              tabText: tabText,
              onTap: (value) {
                setState(() {});
                homeBloc.add(AddTapBarViewIndex(value));
              },
            ),

            // SliverToBoxAdapter(
            //   // child: Container(
            //   //   width: vw,
            //   //   height: vh / 2,
            //   //   child: PageView(
            //   //     scrollDirection: Axis.horizontal,
            //   //     children: [
            //   //       Container(
            //   //         height: vh / 2,
            //   //         width: vw,
            //   //         color: Colors.pink,
            //   //       ),
            //   //       // Container(
            //   //       //   height: vh,
            //   //       //   width: vw,
            //   //       //   color: Colors.pink,
            //   //       // )
            //   //     ],
            //   //   ),
            //   // ),
            //   child: Column(
            //     children: [
            //       PageView(
            //         physics: NeverScrollableScrollPhysics(),
            //         // allowImplicitScrolling: false,
            //         pageSnapping: false,
            //         scrollDirection: Axis.horizontal,
            //         children: [
            //           Container(
            //             height: vh,
            //             width: vw,
            //             color: Colors.pink,
            //           ),
            //           Container(
            //             height: vh,
            //             width: vw,
            //             color: Colors.pink,
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // )

            // BlocBuilder<SubjectBloc, SubjectState>(
            //   builder: (context, state) {
            //     return Container();
            //   },
            // )

            _tabController.index == 0
                ? HomeTipoDeComercio(categories: 'todo')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 1
                ? HomeTipoDeComercio(categories: 'supermercado')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 2
                ? HomeTipoDeComercio(categories: 'comida rápida')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 3
                ? HomeTipoDeComercio(categories: 'drogueria')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 4
                ? HomeTipoDeComercio(categories: 'ferreteria')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 5
                ? HomeTipoDeComercio(categories: 'restaurantes')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 6
                ? HomeTipoDeComercio(categories: 'calzado')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 7
                ? HomeTipoDeComercio(categories: 'cosmetiscos')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 8
                ? HomeTipoDeComercio(categories: 'electrónicos')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 9
                ? HomeTipoDeComercio(categories: 'licor')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 10
                ? HomeTipoDeComercio(categories: 'carniceria')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),

            _tabController.index == 11
                ? HomeTipoDeComercio(categories: 'minimercado')
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({
    Key key,
    @required TabController tabController,
    @required this.tabText,
    @required this.onTap,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<Tab> tabText;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      // floating: true,
      pinned: true,
      delegate: _SliverCustomHeaderDelegate(
        minHeight: 51,
        maxHeight: 51,
        child: Container(
          color: hexaColor('#232323'),
          child: Column(
            children: [
              TabBar(
                onTap: this.onTap,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: hexaColor('#E6D29F'),
                unselectedLabelColor: Colors.white,
                controller: _tabController,
                indicatorColor: hexaColor('#E6D29F'),
                indicatorWeight: 4,
                isScrollable: true,
                physics: BouncingScrollPhysics(),
                indicator: MD2Indicator(
                  indicatorHeight: 4,
                  indicatorColor: hexaColor('#E6D29F'),
                  indicatorSize: MD2IndicatorSize.normal,
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
    );
  }
}

class BuscadorYPerfil extends StatelessWidget {
  const BuscadorYPerfil({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      pinned: false,
      delegate: _SliverCustomHeaderDelegate(
        child: Container(
          color: hexaColor('#232323'),
          alignment: Alignment.centerLeft,
          child: AppBar(
            tabController: _tabController,
          ),
        ),
        minHeight: 60,
        maxHeight: 60,
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  AppBar({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  // final String phone = '${}';

  @override
  Widget build(BuildContext context) {
    final List<String> phoneTemp = Pref().phone.substring(3, 13).split('');
    final String nombre = Pref().nombe;
    phoneTemp.insert(3, ' ');
    phoneTemp.insert(7, ' ');

    String phone = phoneTemp.join();

    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

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
              MenuButton()
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
