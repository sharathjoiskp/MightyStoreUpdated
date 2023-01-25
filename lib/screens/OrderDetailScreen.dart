import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/models/OrderNotesResponse.dart';
import 'package:mightyAdmin/models/OrderResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'ProductDetailScreen.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderResponse? mOrderModel;
  static String tag = '/OrderDetailScreen';

  OrderDetailScreen({Key? key, this.mOrderModel}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<String> mStatusList = ['pending', 'processing', 'on-hold', 'completed', 'cancelled', 'refunded ', 'failed'];
  String? mSelectedStatusIndex = 'pending';
  String mErrorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  void updateOrderAPI(id, status) async {
    appStore.setLoading(true);
    var request = {"status": status};
    await updateOrder(id, request).then((res) async {
      widget.mOrderModel!.status = mSelectedStatusIndex;
      appStore.setLoading(false);
      toast('Successfully update status');
      setState(() {});
      finish(context, true);
    }).catchError((error) {
      appStore.setLoading(false);
      mErrorMsg = error.toString();
      print(error.toString());
      setState(() {});
    });
  }

  Widget mStatus(OrderResponse mOrderResponse) {
    if (mOrderResponse.status == 'pending') return Text(mOrderResponse.status!, style: primaryTextStyle(color: pendingColor));
    if (mOrderResponse.status == 'processing') return Text(mOrderResponse.status!, style: primaryTextStyle(color: processingColor));
    if (mOrderResponse.status == 'on-hold') return Text(mOrderResponse.status!, style: primaryTextStyle(color: primaryColor));
    if (mOrderResponse.status == 'completed') return Text(mOrderResponse.status!, style: primaryTextStyle(color: completeColor));
    if (mOrderResponse.status == 'cancelled') return Text(mOrderResponse.status!, style: primaryTextStyle(color: cancelledColor));
    if (mOrderResponse.status == 'refunded') return Text(mOrderResponse.status!, style: primaryTextStyle(color: refundedColor));
    if (mOrderResponse.status == 'failed') return Text(mOrderResponse.status!, style: primaryTextStyle(color: failedColor));
    if (mOrderResponse.status == 'any')
      return Text(mOrderResponse.status!, style: primaryTextStyle(color: primaryColor));
    else
      return Text(mOrderResponse.status!, style: primaryTextStyle(color: primaryColor));
  }

  @override
  Widget build(BuildContext context) {
    Widget mOrderInfo() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            cachedImage(ic_shopping, height: 50, width: 50, fit: BoxFit.cover),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("lbl_payment_via".translate + " " + widget.mOrderModel!.paymentMethod!, style: boldTextStyle()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    mStatus(widget.mOrderModel!),
                    16.width,
                    Text(convertDate(widget.mOrderModel!.dateCreated), style: secondaryTextStyle(), maxLines: 1),
                  ],
                )
              ],
            ).expand(),
          ],
        ),
      );
    }

    Widget mItemInfo() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.all(spacing_middle.toDouble()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("lbl_items".translate, style: boldTextStyle()),
            Divider(),
            16.height,
            widget.mOrderModel!.lineItems!.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.mOrderModel!.lineItems!.length,
                    itemBuilder: (context, i) {
                      OrderResponse data = widget.mOrderModel!;
                      return GestureDetector(
                        onTap: () {
                          ProductDetailScreen(mProId: data.lineItems![i].productId).launch(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: spacing_middle.toDouble()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.lineItems![i].name}', style: primaryTextStyle(), maxLines: 2),
                              4.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("lbl_qty".translate + " " + data.lineItems![i].quantity.toString(), style: primaryTextStyle(color: appStore.textSecondaryColor)),
                                  PriceWidget(price: data.lineItems![i].price, size: 16)
                                ],
                              )
                            ],
                          ).paddingOnly(top: 4),
                        ),
                      );
                    },
                  )
                : SizedBox(),
          ],
        ),
      );
    }

    Widget mPaymentInfo() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            8.height,
            Text("lbl_payment_info".translate, style: boldTextStyle()),
            Divider(),
            spacing_standard_new.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("lbl_discount_total".translate, style: secondaryTextStyle()),
                PriceWidget(
                  price: widget.mOrderModel!.discountTotal,
                  size: 14.toDouble(),
                )
              ],
            ),
            spacing_standard.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("lbl_shipping_total".translate, style: secondaryTextStyle()),
                PriceWidget(
                  price: widget.mOrderModel!.shippingTotal,
                  size: 14.toDouble(),
                )
              ],
            ).visible(widget.mOrderModel!.paymentMethod != "cod"),
            spacing_standard.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("lbl_total_amount".translate, style: secondaryTextStyle(color: primaryColor,size: 16)),
                PriceWidget(price: widget.mOrderModel!.total, size: 16.toDouble(),color:  primaryColor,),
              ],
            ),
            8.height,
          ],
        ),
      );
    }

    Widget mShipping() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            8.height,
            Text("lbl_shipping".translate, style: boldTextStyle()),
            Divider(),
            Text(
              widget.mOrderModel!.shipping!.firstName! + " " + widget.mOrderModel!.shipping!.lastName!,
              style: primaryTextStyle(),
            ),
            4.height,
            Text(
              widget.mOrderModel!.shipping!.address_1! + "\n" + widget.mOrderModel!.shipping!.city! + "\n" + widget.mOrderModel!.shipping!.country! + "\n" + widget.mOrderModel!.shipping!.state!,
              style: secondaryTextStyle(),
            ),
          ],
        ),
      );
    }

    Widget mBilling() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            spacing_standard.height,
            Text("lbl_billing".translate, style: boldTextStyle()),
            Divider(),
            Text(
              widget.mOrderModel!.billing!.firstName! + " " + widget.mOrderModel!.billing!.lastName!,
              style: primaryTextStyle(),
            ),
            4.height,
            Text(
              widget.mOrderModel!.billing!.address_1! + "\n" + widget.mOrderModel!.billing!.city! + "\n" + widget.mOrderModel!.billing!.country! + "\n" + widget.mOrderModel!.billing!.state!,
              style: secondaryTextStyle(),
            ),
          ],
        ),
      );
    }

    Widget mUpdateStatus() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.height,
            Text("lbl_change_status".translate, style: boldTextStyle()),
            Divider(),
            DropdownButton(
              isExpanded: true,
              dropdownColor: appStore.appBarColor,
              value: mSelectedStatusIndex,
              style: boldTextStyle(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: appStore.iconColor,
              ),
              underline: 0.height,
              onChanged: (dynamic newValue) {
                setState(() {
                  mSelectedStatusIndex = newValue;
                  updateOrderAPI(widget.mOrderModel!.id, newValue);
                });
              },
              items: mStatusList.map((category) {
                return DropdownMenuItem(
                  child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                  value: category,
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    Widget orderNotes() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: boxDecorationWithRoundedCorners(border: Border.all(width: 0.1),backgroundColor: context.dividerColor),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacing_standard.height,
            Text("lbl_notes".translate, style: boldTextStyle()),
            Divider(),
            FutureBuilder<List<OrderNotesResponse>>(
              future: getOrderNotes(widget.mOrderModel!.id),
              builder: (_, snap) {
                if (snap.hasData) {
                  if (snap.data!.isNotEmpty) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          return Text(snap.data![i].note!, style: primaryTextStyle());
                        });
                  } else {
                    return noDataWidget(context);
                  }
                }
                return snapWidgetHelper(snap);
              },
            )
          ],
        ),
      ).visible(widget.mOrderModel!.customerNote != null && !widget.mOrderModel!.customerNote.isEmptyOrNull);
    }

    Widget mBody() {
      return SingleChildScrollView(
        child: Column(
          children: [
            mOrderInfo(),
            mUpdateStatus(),
            mShipping(),
            mBilling(),
            mItemInfo(),
            orderNotes(),
            mPaymentInfo(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: appStore.scaffoldBackground,
      appBar: appBarWidget(
        "",
        titleWidget: Text("${'lbl_order_number'.translate} #${widget.mOrderModel!.id}", style: boldTextStyle(color: Colors.white)),
        elevation: 10,
        color: primaryColor,
        backWidget: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(Icons.arrow_back, color: white),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          mBody(),
          Observer(
            builder: (_) => loading().center().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
