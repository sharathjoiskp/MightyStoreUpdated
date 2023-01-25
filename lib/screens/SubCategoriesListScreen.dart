import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mightyAdmin/component/CategoryItemWidget.dart';
import 'package:mightyAdmin/models/CategoryResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class SubCategoriesListScreen extends StatefulWidget {
  static String tag = '/SubCategoriesListScreen';

  final int? categoryId;

  SubCategoriesListScreen({this.categoryId});

  @override
  SubCategoriesListScreenState createState() => SubCategoriesListScreenState();
}

class SubCategoriesListScreenState extends State<SubCategoriesListScreen> {
  AsyncMemoizer asyncMemoizer = AsyncMemoizer<List<CategoryResponse>>();

  List<CategoryResponse>? categoryList = [];
  CategoryResponse data = CategoryResponse();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("lbl_Category".translate, showBack: true, color: primaryColor, textColor: white),
      body: FutureBuilder<List<CategoryResponse>>(
          future: asyncMemoizer.runOnce(() => getSubCategories(widget.categoryId)).then((value) => value as List<CategoryResponse>),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data!.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    data = snap.data![i];
                    categoryList = snap.data;
                    return CategoryItemWidget(data: data, index: i, categoryList: snap.data).paddingSymmetric(vertical: 8);
                  },
                );
              } else {
                return NoDataFound(
                    title: 'no_sub_category'.translate,
                    onPressed: () {
                      finish(context);
                    });
              }
            }
            return snapWidgetHelper(
              snap,
              errorWidget: Container(
                child: Text(snap.error.toString().validate(), style: primaryTextStyle()).paddingAll(16).center(),
                height: context.height(),
                width: context.width(),
              ),
            );
          }),
    );
  }
}
