import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/ReviewResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/UpdateReviewScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ReviewItemWidget extends StatefulWidget {
  final ReviewResponse? data;
  final Function? onUpdate;
  final Function(int)? onDelete;

  ReviewItemWidget({this.data, this.onUpdate, this.onDelete});

  @override
  _ReviewItemWidgetState createState() => _ReviewItemWidgetState();
}

class _ReviewItemWidgetState extends State<ReviewItemWidget> {
  Future<void> deleteReviews() async {
    hideKeyboard(context);

    appStore.setLoading(true);

    deleteReview(reviewId: widget.data!.id).then((res) {
      if (res.status == 'trash') toast('successfully_deleted'.translate);
    }).catchError((error) {
      log(error.toString());
    }).whenComplete(() {
      LiveStream().emit(REMOVE_REVIEW, true);
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        cachedImage(getStringAsync(AVATAR), height: 70, width: 70, fit: BoxFit.cover).cornerRadiusWithClipRRect(35),
        8.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            4.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(parseHtmlString('${widget.data!.reviewer.capitalizeFirstLetter()}'), style: boldTextStyle()).paddingLeft(4),
                Text(DateFormat.yMMMEd().format(DateTime.parse(widget.data!.dateCreated!)), style: secondaryTextStyle(size: 14)),
              ],
            ),
            2.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBarWidget(
                  onRatingChanged: (rating) {},
                  itemCount: 5,
                  size: 18,
                  activeColor: Colors.amber,
                  inActiveColor: grey,
                  allowHalfRating: true,
                  disable: true,
                  rating: widget.data!.rating!.toDouble(),
                ),
                Row(
                  children: [
                    commonEditButtonComponent(
                        icon: Icons.edit,
                        color: primaryColor,
                        onCall: () async {
                          log(widget.data!.rating!.toDouble());
                          if (isVendor) {
                            toast("admin_toast".translate);
                            return;
                          }
                          var res = await UpdateReviewScreen(data: widget.data).launch(context);
                          if (res ?? false) {
                            setState(() {});
                            widget.onUpdate?.call();
                          }
                        }),
                    commonEditButtonComponent(
                        icon: Icons.delete,
                        color: redColor,
                        onCall: () async {
                          if (isVendor) {
                            toast("admin_toast".translate);
                            return;
                          }
                          showConfirmDialogCustom(context, title: "lbl_confirmation_Delete_Review".translate, onAccept: (_) {
                            deleteReviews();
                          }, dialogType: DialogType.DELETE, positiveText: 'lbl_Delete'.translate, negativeText: 'lbl_cancel'.translate);
                        }),
                  ],
                ),
              ],
            ),
            Text(parseHtmlString('${widget.data!.review}'), style: secondaryTextStyle(size: 14)).paddingLeft(4),
          ],
        ).expand(),
      ],
    );
  }
}
