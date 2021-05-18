import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/shared/pref.dart';
import '../../utils/utils.dart';
import 'bloc/home_bloc.dart';
import 'mapa_page/mapa_page.dart';
import 'tiendas_page/tiendas_page.dart';

class Home extends StatefulWidget {
  static final String pathName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
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
  }

  @override
  bool get wantKeepAlive => true;
}
