import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'BackgroundGradient.dart';

class PageImage extends StatefulWidget {
  static final String pathName = '/PageImage';

  @override
  _PageImageState createState() => _PageImageState();
}

class _PageImageState extends State<PageImage> {
  PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    Future.delayed(Duration.zero, () {
      setState(() {
        final args = ModalRoute.of(context).settings.arguments as int;

        _controller.jumpToPage(args);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomBackgroundGradient(
        child: PageView.builder(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              color: hexaColor('#BEA07D'),
              child: Text('$index'),
            );
          },
        ),
      ),
    );
  }
}
