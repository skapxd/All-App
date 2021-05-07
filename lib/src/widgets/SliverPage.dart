import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';

class SliverPage extends StatelessWidget {
  static final String pathName = '/SliverPage';

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      // body: _Titulo(),
      // body: _ListItems(),
      body: _MainScroll(),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = [
    _Item('Orange', Color(0xffF08F66)),
    _Item('Family', Color(0xffF2A38A)),
    _Item('Subscriptions', Color(0xffF7CDD5)),
    _Item('Books', Color(0xffFCEBAF)),
    _Item('Orange', Color(0xffF08F66)),
    _Item('Family', Color(0xffF2A38A)),
    _Item('Subscriptions', Color(0xffF7CDD5)),
    _Item('Books', Color(0xffFCEBAF)),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        // SliverAppBar(
        //   backgroundColor: Colors.red,
        //   title: _Titulo(),
        //   floating: true,
        // ),
        //

        SliverPersistentHeader(
          floating: true,
          delegate: _SliverCustomHeaderDelegate(
            child: Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: _Titulo(),
            ),
            minHeight: 190,
            maxHeight: 200,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return this.items[index];
            },
            childCount: this.items.length,
          ),
        )
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

class _Titulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'New',
                style: TextStyle(
                  color: hexaColor('#532128'),
                  fontSize: 50,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    'List',
                    style: TextStyle(
                      color: hexaColor('#d93a39'),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 8,
                  color: hexaColor('#f7cdd5'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ListItems extends StatelessWidget {
  final items = [
    _Item('Orange', Color(0xffF08F66)),
    _Item('Family', Color(0xffF2A38A)),
    _Item('Subscriptions', Color(0xffF7CDD5)),
    _Item('Books', Color(0xffFCEBAF)),
    _Item('Orange', Color(0xffF08F66)),
    _Item('Family', Color(0xffF2A38A)),
    _Item('Subscriptions', Color(0xffF7CDD5)),
    _Item('Books', Color(0xffFCEBAF)),
  ];

  _ListItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}

class _Item extends StatelessWidget {
  final String name;
  final Color color;
  const _Item(
    this.name,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        this.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
