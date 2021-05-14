import '../../../utils/Color.dart';
import '../../../widgets/BackgroundGradient.dart';
import '../../../widgets/PageImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhotosPage extends StatefulWidget {
  static final String pathName = '/PhotosPage';

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print('ScrollListener ${_scrollController.offset}');
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexaColor('#D5D5D5'),
        splashColor: hexaColor('#FFFFFF'),
        child: Icon(
          // Icons.cloud_upload,
          Icons.add_photo_alternate_outlined,
          color: hexaColor('#232323'),
        ),
        onPressed: () {
          Navigator.pushNamed(context, PageImage.pathName);
        },
      ),
      appBar: AppBar(
        title: Text(
          'IMAGENES',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: hexaColor('#E6D29F'),
            letterSpacing: 5,
          ),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(vw),
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: hexaColor('#303030'),
      ),
      backgroundColor: hexaColor('#303030'),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          // itemCount: 8,
          crossAxisCount: 4,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,

          staggeredTileBuilder: (int index) {
            // double size
            return StaggeredTile.count(
              2,
              index.isOdd ? 3 : 3.3,
            );
          },

          itemBuilder: (BuildContext context, int index) => new Container(
            decoration: BoxDecoration(
              color: index.isEven
                  ? hexaColor('#D6D6D6', opacity: 0.5)
                  : hexaColor('#D6D6D6', opacity: 0.3),
              borderRadius: BorderRadius.circular(vw * 0.07),
            ),
            child: InkWell(
              onTap: () {
                print('imagenes: $index');
                Navigator.pushNamed(
                  context,
                  PageImage.pathName,
                  arguments: index,
                );
              },
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
