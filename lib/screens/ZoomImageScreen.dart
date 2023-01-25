import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImageScreen extends StatefulWidget {
  final mProductImage;

  ZoomImageScreen({Key? key, this.mProductImage}) : super(key: key);

  @override
  _ZoomImageScreenState createState() => _ZoomImageScreenState();
}

class _ZoomImageScreenState extends State<ZoomImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('', showBack: true, color: primaryColor, textColor: white),
      body: PhotoView(
        imageProvider: NetworkImage(widget.mProductImage),
      ),
    );
  }
}
