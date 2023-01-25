import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/OrderResponse.dart';
import 'package:mightyAdmin/screens/OrderDetailScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class OrderCardWidget extends StatefulWidget {
  OrderResponse? orderResponse;
  final Function? onUpdate;

  OrderCardWidget({this.orderResponse, this.onUpdate});

  @override
  _OrderCardWidgetState createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  OrderResponse? data;
  String currency = '₹';

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  init() async {
    // data = widget.orderResponse;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    log("------------------->0${widget.orderResponse}");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: widget.orderResponse != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.only(right: 6),
                  decoration: boxDecorationDefault(
                    color: statusColor(widget.orderResponse!.status).withOpacity(0.7),
                  ),
                  child: Text("#" + widget.orderResponse!.id.toString(), style: boldTextStyle(color: Colors.white)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.orderResponse!.billing!.firstName.validate().capitalizeFirstLetter()}' '${widget.orderResponse!.billing!.lastName}', style: boldTextStyle()),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: statusColor(widget.orderResponse!.status).withOpacity(0.6), borderRadius: radius(5)),
                          child: statusWidget(widget.orderResponse!.status),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currency + widget.orderResponse!.total.validate(), style: primaryTextStyle()),
                        Text(convertDate(widget.orderResponse!.dateCreated.validate()), style: secondaryTextStyle(), maxLines: 1),
                      ],
                    ),
                  ],
                ).expand(),
              ],
            )
          : SizedBox(),
    ).onTap(() async {
      bool? res = await OrderDetailScreen(mOrderModel: widget.orderResponse).launch(context);
      if (res ?? false) {
        widget.onUpdate?.call();
      }
    });
  }
}

Widget statusWidget(String? status) {
  Widget widget = Container();
  switch (status) {
    case "pending":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
    case "processing":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
    case "on-hold":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
    case "completed":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
    case "cancelled":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
    case "refunded":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
    case "failed":
      return Text(status!.capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white, size: 12));
  }
  return widget;
}

Color statusColor(String? status) {
  Color color = primaryColor;
  switch (status) {
    case "pending":
      return pendingColor;
    case "processing":
      return processingColor;
    case "on-hold":
      return primaryColor;
    case "completed":
      return completeColor;
    case "cancelled":
      return cancelledColor;
    case "refunded":
      return refundedColor;
    case "failed":
      return failedColor;
    case "any":
      return primaryColor;
  }
  return color;
}
