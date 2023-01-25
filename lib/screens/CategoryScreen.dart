import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mightyAdmin/component/CategoryItemWidget.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/CategoryResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/UpdateCategoryScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryScreen extends StatefulWidget {
  static String tag = '/CategoryScreen';

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  List<CategoryResponse> categoryList = [];
  CategoryResponse data = CategoryResponse();
  ScrollController scrollController = ScrollController();

  int page = 1;
  bool mIsLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    getAllCategoryList();

    scrollController.addListener(() {
      if ((scrollController.position.pixels - 100) == (scrollController.position.maxScrollExtent - 100)) {
        if (!mIsLastPage) {
          page++;

          getAllCategoryList();
        }
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> getAllCategoryList() async {
    appStore.setLoading(true);

    await getAllCategory(page: page).then((res) async {
      if (page == 1) categoryList.clear();

      categoryList.addAll(res);
      mIsLastPage = res.length != perPage;

      setState(() {});
    }).catchError((e) {
      log(e.toString());
      toast(e.toString());
    });

    appStore.setLoading(false);
  }

  @override
  void dispose() {
    super.dispose();
    LiveStream().dispose(ADD_CATEGORY);
    scrollController.dispose();
  }

  @override
  void didUpdateWidget(covariant CategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("lbl_Category".translate, showBack: true, color: primaryColor, textColor: white),
      body: Stack(
        children: [
          if (categoryList.isNotEmpty)
            SingleChildScrollView(
              child: Column(
                children: [
                  StaggeredGridView.countBuilder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categoryList.length,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, i) {
                      CategoryResponse data = categoryList[i];
                      return CategoryItemWidget(data: data, index: i, categoryList: categoryList);
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.fit(1);
                    },
                  ),
                  60.height,
                ],
              ),
            ),
          NoDataFound(
            title: 'no_attribute_available'.translate,
            onPressed: () {
              init();
            },
          ).visible(!appStore.isLoading && categoryList.isEmpty),
          Observer(builder: (_) => loading().visible(appStore.isLoading))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        backgroundColor: primaryColor,
        onPressed: () async {
          if (isVendor) {
            toast("admin_toast".translate);
            return;
          }
          bool? res = await UpdateCategoryScreen(isEdit: false, categoryList: categoryList, categoryData: data).launch(context);
          if (res ?? true) {
            page = 1;
            appStore.setLoading(true);
            categoryList.clear();
            init();
            setState(() {});
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
