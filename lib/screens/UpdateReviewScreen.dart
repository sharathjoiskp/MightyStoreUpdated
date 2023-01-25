import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/models/ReviewResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class UpdateReviewScreen extends StatefulWidget {
  static String tag = '/UpdateReviewScreen';
  final ReviewResponse? data;

  UpdateReviewScreen({this.data});

  @override
  UpdateReviewScreenState createState() => UpdateReviewScreenState();
}

class UpdateReviewScreenState extends State<UpdateReviewScreen> {
  TextEditingController reviewCont = TextEditingController();

  int totalStar = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    reviewCont.text = parseHtmlString(widget.data!.review.validate());
    totalStar = widget.data!.rating.validate();
  }

  Future<void> updateReviews() async {
    appStore.setLoading(true);

    Map req = {"rating": totalStar, "review": reviewCont.text.validate()};

    await updateReview(reviewId: widget.data!.id.validate(), request: req).then((res) {
      widget.data!.rating = totalStar;
      widget.data!.review = reviewCont.text.validate();
      toast('lbl_update_successfully'.translate);

      finish(context, true);
    }).catchError((error) {
      log(error.toString());
      toast(error.toString().validate());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("lbl_Update_Review".translate, color: primaryColor, textColor: Colors.white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                AppTextField(
                  controller: reviewCont,
                  textFieldType: TextFieldType.OTHER,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, "lbl_Product_Review".translate),
                  maxLines: 5,
                ),
                16.height,
                RatingBarWidget(
                    spacing: 8,
                    itemCount: 5,
                    size: 36,
                    activeColor: Colors.amber,
                    rating: totalStar.toDouble(),
                    onRatingChanged: (rating) {
                      log(rating);
                      totalStar = rating.toInt();
                      setState(() {});
                    }),
                16.height,
                AppButton(
                  text: "lbl_Edit".translate,
                  color: primaryColor,
                  textColor: white,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);
                    updateReviews();
                  },
                ),
              ],
            ),
          ),
          Observer(builder: (_) => loading().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
