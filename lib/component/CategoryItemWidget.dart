import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/CategoryResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/SubCategoriesListScreen.dart';
import 'package:mightyAdmin/screens/UpdateCategoryScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryItemWidget extends StatefulWidget {
  final List<CategoryResponse>? categoryList;
  final CategoryResponse? data;
  final int? index;

  CategoryItemWidget({this.categoryList, this.data, this.index});

  @override
  _CategoryItemWidgetState createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  Future<void> deleteCategories() async {
    hideKeyboard(context);

    appStore.setLoading(true);

    deleteCategory(categoryId: widget.data!.id).then((res) {
      toast('successfully_deleted');
      finish(context, true);
    }).catchError((error) {
      log(error.toString());
      toast(error.toString().validate());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration(context, radius: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cachedImage(widget.data!.image != null ? widget.data!.image!.src.validate() : ic_placeHolder, height: 140, width: context.width(), fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(defaultRadius),
          6.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(parseHtmlString(widget.data!.name.validate()), style: primaryTextStyle()).expand(),
              commonEditButtonComponent(
                  icon: Icons.edit,
                  color: primaryColor,
                  onCall: () async {
                    if (isVendor) {
                      toast("admin_toast".translate);
                      return;
                    }
                    bool? res = await UpdateCategoryScreen(categoryList: widget.categoryList, categoryData: widget.data).launch(context);

                    if (res ?? true) {
                      setState(() {});
                    }
                  }),
              commonEditButtonComponent(
                  icon: Icons.delete,
                  color: redColor,
                  onCall: () async {
                    showConfirmDialogCustom(context, title: "lbl_confirmation_Delete_Category".translate, onAccept: (_) {
                      deleteCategories();
                    }, dialogType: DialogType.DELETE, positiveText: 'lbl_cancel'.translate, negativeText: 'lbl_Delete'.translate);
                  }),
            ],
          ).paddingOnly(left: 8, right: 6, bottom: 8),
        ],
      ),
    ).onTap(() {
      if (isVendor) {
        toast("admin_toast".translate);
        return;
      }
      SubCategoriesListScreen(categoryId: widget.data!.id.validate()).launch(context);
    });
  }
}
