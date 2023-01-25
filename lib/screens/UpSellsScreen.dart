import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';

class UpSellsScreen extends StatefulWidget {
  final bool? isGroup;
  final List<ProductDetailResponse1>? grpProduct;

  UpSellsScreen({this.isGroup, this.grpProduct});

  @override
  _UpSellsScreenState createState() => _UpSellsScreenState();
}

class _UpSellsScreenState extends State<UpSellsScreen> {
  TextEditingController search = TextEditingController();
  List<ProductDetailResponse1> productModel = [];
  List<ProductDetailResponse1> searchProductModel = [];
  String mErrorMsg = "";

  int page = 1;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() => init());
  }

  init() async {
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    appStore.setLoading(true);
    await getAllProducts(page).then((res) {
      log(res.length);
      productModel.addAll(res);
      searchProductModel.addAll(res);
      appStore.setLoading(false);
      if (res.isEmpty) {
        mErrorMsg = ('no_data_found'.translate);
      } else {
        mErrorMsg = '';
      }
      setState(() {});
    }).catchError((error) {
      if (!mounted) return;
      mErrorMsg = error.toString();
      setState(() {});
    });
  }

  onSearchTextChanged(String text) async {
    productModel.clear();
    if (text.isEmpty) {
      productModel.addAll(searchProductModel);
      setState(() {});
      return;
    }
    searchProductModel.forEach((product) {
      if (product.name.toLowerCase().contains(text)) productModel.add(product);
    });

    setState(() {});
  }

  List<ProductDetailResponse1> getData1() {
    List<ProductDetailResponse1> selected = [];

    productModel.forEach((value) {
      if (value.isCheck == true) {
        selected.add(value);
      }
    });
    setState(() {});
    return selected;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBar = Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.withOpacity(0.2)),
      child: TextField(
        onChanged: onSearchTextChanged,
        autofocus: false,
        onTap: () {},
        textInputAction: TextInputAction.go,
        controller: search,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: white_color,
          hintText: 'lbl_search'.translate,
          hintStyle: primaryTextStyle( size: 20),
          prefixIcon: Icon(Icons.search,color: context.iconColor, size: 25),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        print(getData1().length);
        finish(context, getData1());
        return false;
      },
      child: Scaffold(
        appBar: appBarWidget(
          "",
          titleWidget: Text(widget.isGroup == true ? "lbl_grp_product".translate : 'lbl_upSell_product'.translate, maxLines: 1, style: boldTextStyle(color: white), overflow: TextOverflow.ellipsis),
          elevation: 10,
          color: context.primaryColor,
          backWidget: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Icon(Icons.arrow_back, color: white),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  searchBar,
                  ListView.builder(
                    itemCount: productModel.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 60),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: productModel[index].isCheck,
                        onChanged: (v) {
                          log(productModel[index].id);
                          productModel[index].isCheck = !productModel[index].isCheck;

                          setState(() {});
                        },
                        title: Text(productModel[index].name,style: primaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
                      );
                    },
                  ),
                ],
              ),
            ),
            Observer(builder: (_) => loading().visible(appStore.isLoading)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: Icon(Icons.check, color: Colors.white),
          onPressed: () {
            print(getData1().length);
            finish(context, getData1());
          },
        ),
      ),
    );
  }
}
