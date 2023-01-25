import 'package:flutter/material.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class CommonComponent extends StatelessWidget {
  String? name;
  String? image;
  Function? onUpdate;
  Function? onDelete;
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius)),
            child: cachedImage(image, height: 60, width: 60, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius),
          ),
          8.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.height,
              Text(parseHtmlString(name), style: primaryTextStyle()),
              4.height,
              Row(
                children: [
                  Text("lbl_Edit".translate, style: primaryTextStyle(color: Colors.blue)).onTap(onUpdate),
                  24.width,
                  Text("lbl_Delete".translate, style: primaryTextStyle(color: Colors.red)).onTap(onDelete),
                ],
              ),
            ],
          )
        ],
      ),
    ).onTap(onTap);
  }
}
