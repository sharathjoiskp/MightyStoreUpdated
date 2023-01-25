import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/component/ProductItemWidget.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'AddProductScreen.dart';

class ProductFragment extends StatefulWidget {
  static String tag = '/ProductFragment';

  @override
  ProductFragmentState createState() => ProductFragmentState();
}

class ProductFragmentState extends State<ProductFragment> {
  bool switchValue = false;
  bool mIsLastPage = false;
  List<ProductDetailResponse1> mProductModel = [];
  ScrollController scrollController = ScrollController();
  String mErrorMsg = '';
  int page = 1;

  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if ((scrollController.position.pixels - 100) == (scrollController.position.maxScrollExtent - 100)) {
        if (!mIsLastPage) {
          page++;

          fetchProductData();
        }
      }
    });
  }

  Future<void> init() async {
    fetchProductData();
  }

  Future fetchProductData() async {
    appStore.setLoading(true);
    await getAllProducts(page).then((res) {
      if (!mounted) return;

      mProductModel.addAll(res);
      mIsLastPage = res.length != perPage;

      setState(() {});
    }).catchError((error) {
      if (!mounted) return;
      mErrorMsg = error.toString();
      setState(() {});
    });
    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.scaffoldBackground,
      appBar: appBarWidget(
        "",
        titleWidget: Text("lbl_my_products".translate, maxLines: 1, style: boldTextStyle(color: white), overflow: TextOverflow.ellipsis),
        elevation: 0,
        color: primaryColor,
        showBack: false,
        center: true,
      ),
      body: RefreshIndicator(
        edgeOffset: context.height() / 2 - 135,
        onRefresh: () {
          return fetchProductData();
        },
        child: Stack(
          children: [
            ListView.separated(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              controller: scrollController,
              itemCount: mProductModel.length,
              separatorBuilder: (_, index) {
                return Divider(color: appStore.iconSecondaryColor);
              },
              itemBuilder: (context, i) {
                ProductDetailResponse1 data = mProductModel[i];
                return ProductItemWidget(
                  product: data,
                  onUpdate: () {
                    mProductModel.clear();
                    init();
                    setState(() {});
                  },
                  onDelete: (id) {
                    mProductModel.removeWhere((element) => element.id == id);
                    log(mProductModel);
                    appStore.setLoading(true);
                    mProductModel.clear();
                    init();
                    setState(() {});
                  },
                );
              },
            ),
            Observer(builder: (_) => loading().visible(appStore.isLoading)),
            Text(mErrorMsg.validate(), style: primaryTextStyle()).center(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        backgroundColor: primaryColor,
        onPressed: () async {
          var res = await AddProductScreen(isUpdate: false).launch(context);
          if (res != null) {
            mProductModel.clear();
            init();
            setState(() {});
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
