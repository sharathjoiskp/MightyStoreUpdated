import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/AttributeCustomModel.dart';
import 'package:mightyAdmin/models/AttributeResponseModel.dart';
import 'package:mightyAdmin/models/AttributeTermsResponse.dart';
import 'package:mightyAdmin/models/CategoryResponse.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/models/ProductResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/MediaImageList.dart';
import 'package:mightyAdmin/utils/AppColors.dart' as color;
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import 'UpSellsScreen.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatefulWidget {
  static String tag = '/AddProductScreen';
  String title;
  final ProductDetailResponse1? singleProductResponse;
  bool? isUpdate = false;

  AddProductScreen({this.title = 'add_product', this.singleProductResponse, this.isUpdate});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  AttributeResponseModel? attributeResponse;
  CategoryResponse? pCategoryCont;

  DateTime? selectedToDate = DateTime.now();
  DateTime? selectedFromDate = DateTime.now();

  List<CategoryResponse> categoryData = [];
  List<CategoryResponse> mCategoryModel = [];
  List<AttributeResponseModel> mAttributeModel = [];
  List<Images1> selectedImages = [];
  List<PAttributes> selectedAttributes = [];
  List<Categories> category = [];
  List<AttributeTermsResponse> mAttributeTermsModel = [];
  List upSellsId = [];
  List groupProductId = [];
  List<AttributeResponseModel> mAttributeName = [];
  List<String> productType = ['simple', 'grouped', 'external'];
  List<String> status = [];
  List selectedCategories = [];
  List files = [];
  List<AttributeSection> attributes = [];
  List<ProductDetailResponse1> upSells = [];
  List<ProductDetailResponse1> grpProduct = [];
  List<String> colorArray = ['#000000', '#f0f2f5'];
  int? id;

  List<Images1> images = [];
  List<Map<String, dynamic>> selectImg = [];

  String mErrorMsg = '';
  String error = 'No Error Detected';
  String? pStatusCont = 'pending';
  String? pTypeCont = "simple";
  String? pAttributeCont;

  bool mAttributeExist = false;
  bool advanceOptions = false;
  bool switchValue = true;
  bool scheduleTime = false;
  bool isAdvance = false;
  bool isRemember = false;
  bool mIsUpdate = false;

  int page = 1;

  TextEditingController pNameCont = TextEditingController();
  TextEditingController pRPriceCont = TextEditingController();
  TextEditingController pSPriceCont = TextEditingController();
  TextEditingController pSFromTimeCont = TextEditingController();
  TextEditingController pSToTimeCont = TextEditingController();
  TextEditingController pDescCont = TextEditingController();
  TextEditingController pShortDescCont = TextEditingController();
  TextEditingController pExternalUrlCont = TextEditingController();
  TextEditingController pButtonTextCont = TextEditingController();
  TextEditingController attributeCont = TextEditingController();

  FocusNode pNameFocus = FocusNode();
  FocusNode pRPriceFocus = FocusNode();
  FocusNode pSPriceFocus = FocusNode();
  FocusNode pSFromTimeFocus = FocusNode();
  FocusNode pSToTimeFocus = FocusNode();
  FocusNode pDescFocus = FocusNode();
  FocusNode pShortDescFocus = FocusNode();
  FocusNode pStatusFocus = FocusNode();
  FocusNode pTypeFocus = FocusNode();
  FocusNode pExternalUrlFocus = FocusNode();
  FocusNode pButtonTextFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  void init() async {
    if (widget.isUpdate!) {
      id = widget.singleProductResponse!.id;
      editProductData();
      fetchAllAttributes();
      log(grpProduct);
    } else {
      getAllCategoryList();
      fetchCategoryData();
      fetchAllAttributes();
    }
  }

  void editProductData() async {
    appStore.setLoading(true);
    if (widget.singleProductResponse != null) {
      widget.title = 'update_product'.translate;
      widget.isUpdate = true;
      pNameCont.text = widget.singleProductResponse!.name;
      log(widget.singleProductResponse!.regularPrice);
      pRPriceCont.text = widget.singleProductResponse!.regularPrice!;
      log(widget.singleProductResponse!.salePrice);
      pSPriceCont.text = widget.singleProductResponse!.salePrice!;
      pSFromTimeCont.text = widget.singleProductResponse!.dateOnSaleFrom.validate();
      pSToTimeCont.text = widget.singleProductResponse!.dateOnSaleFrom.validate();
      pDescCont.text = parseHtmlString(widget.singleProductResponse!.description.validate());
      pShortDescCont.text = parseHtmlString(widget.singleProductResponse!.shortDescription.validate());

      await getAllProducts(page).then((value) {
        Future.forEach(widget.singleProductResponse!.groupedProducts!, (element) {
          grpProduct.add(value.firstWhere((e) => e.id == element));
        });
      });
      log(grpProduct.length);

      await getAllProducts(page).then((value) {
        Future.forEach(widget.singleProductResponse!.upSellIds!, (element) {
          upSells.add(value.firstWhere((e) => e.id == element));
        });
      });
      log(upSells.length);

      pStatusCont = widget.singleProductResponse!.status;
      pTypeCont = widget.singleProductResponse!.type;
      widget.singleProductResponse!.images!.forEach((element) {
        var selectedImage = Images1();
        selectedImage.name = element.name;
        selectedImage.alt = element.alt;
        selectedImage.src = element.src;
        selectedImage.position = element.position;
        return images.add(selectedImage);
      });
      images.forEach((element) {
        selectImg.add({'id': element.id});
      });
      widget.singleProductResponse!.categories!.forEach((element) {
        selectedCategories.add(element.name);
      });
      //upSells = widget.singleProductResponse.upsellId.cast<ProductDetailResponse1>();
      widget.singleProductResponse!.attributes!.forEach((element) {
        List<AttributeTermsResponse> mAttributeTerms = [];
        element.options!.forEach((e) {
          mAttributeTerms.add(AttributeTermsResponse(name: e));
        });
        return attributes.add(AttributeSection(id: element.id, name: element.name, option: mAttributeTerms, variation: element.variation, visible: element.visible));
      });

      pExternalUrlCont.text = widget.singleProductResponse!.externalUrl;
      pButtonTextCont.text = widget.singleProductResponse!.buttonText;
    }
    setState(() {});
    appStore.setLoading(false);
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return CustomTheme(child: child);
        },
        initialDate: selectedToDate!,
        firstDate: selectedFromDate!.subtract(Duration(days: 0)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedToDate) print(picked);
    selectedToDate = picked;
    String date = '${selectedToDate!.day}-${selectedToDate!.month}-${selectedToDate!.year}';
    pSToTimeCont.text = date;
    setState(() {});
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return CustomTheme(child: child);
        },
        initialDate: selectedFromDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedFromDate) print(picked);
    selectedFromDate = picked;
    String date = '${selectedFromDate!.day}-${selectedFromDate!.month}-${selectedFromDate!.year}';
    pSFromTimeCont.text = date;
    setState(() {});
  }

  void addNewProduct() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      createProductApi(isVariable: false);
    }

    setState(() {});
  }

  Future<void> createProductApi({bool? isVariable}) async {
    hideKeyboard(context);
    await getData();
    String convertedDateTime = "${selectedToDate!.year.toString()}-${selectedToDate!.month.toString().padLeft(2, '0')}-${selectedToDate!.day.toString().padLeft(2, '0')}";

    Map request = {
      'name': pNameCont.text,
      'type': pTypeCont ?? 'simple',
      'status': pStatusCont ?? 'publish',
      "post_author": 31,
      'description': pDescCont.text,
      'short_description': pShortDescCont.text,
      'regular_price': pRPriceCont.text,
      'sale_price': pSPriceCont.text,
      'date_on_sale_from_gmt': pSFromTimeCont.text.isNotEmpty ? pSFromTimeCont.text : convertedDateTime,
      'date_on_sale_to_gmt	': pSToTimeCont.text.isNotEmpty ? pSToTimeCont.text : convertedDateTime,
      'stock_status': switchValue == false ? 'outofstock' : 'instock',
      'external_url': pExternalUrlCont.text,
      'button_text': pButtonTextCont.text,
      'categories': category,
      'images': selectImg,
      'upsell_ids': upSellsId,
      'grouped_products': groupProductId,
      'attributes': selectedAttributes
    };

    appStore.setLoading(true);

    await createProduct(request).then((value) async {
      log("ID ${value['id']}");
      log("Type ${value['type']}");

      toast('lbl_Add_product_successfully'.translate);
      /* if (value['type'] == 'variable') {
        ProductVariations(attributes: selectedAttributes, name: value['name'], id: value['id']).launch(context);
      } else {
        finish(context, true);
      }*/
      finish(context, true);
    }).catchError((onError) {
      log(onError.toString());
      toast(onError.toString());
    });
    appStore.setLoading(false);
  }

  void updateExistingProduct() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      updateProductApi();
    }

    setState(() {});
  }

  Future<void> updateProductApi() async {
    hideKeyboard(context);
    await getData();

    int? pid = widget.singleProductResponse!.id;
    String toDate = convertDate(selectedToDate);
    String fromDate = convertDate(selectedFromDate);

    Map request = {
      'name': pNameCont.text,
      'type': pTypeCont ?? 'simple',
      'status': pStatusCont ?? 'publish',
      "post_author": 31,
      'description': pDescCont.text,
      'short_description': pShortDescCont.text,
      'regular_price': pRPriceCont.text,
      'sale_price': pSPriceCont.text,
      'date_on_sale_from_gmt': pSFromTimeCont.text.isNotEmpty ? pSFromTimeCont.text : fromDate,
      'date_on_sale_to_gmt': pSToTimeCont.text.isNotEmpty ? pSToTimeCont.text : toDate,
      'stock_status': switchValue == false ? 'outofstock' : 'instock',
      'external_url': pExternalUrlCont.text,
      'button_text': pButtonTextCont.text,
      'categories': category,
      //'images': selectImg,
      'upsell_ids': upSellsId,
      'grouped_products': groupProductId,
      'attributes': selectedAttributes
    };
    log("regular price:" + pRPriceCont.text);
    log("sale  price:" + pSPriceCont.text);

    appStore.setLoading(true);

    await updateProduct(pid, request).then((value) async {
      log("ID ${value['id']}");
      log("Type ${value['in_stock']}");
      log(value);
      toast('lbl_update_product'.translate);
      /*   if (value['type'] == 'variable') {
        ProductVariations(attributes: selectedAttributes, name: value['name'], id: value['id']).launch(context);
      } else {
        finish(context, true);
      }*/
      finish(context, true);
    }).catchError((onError) {
      log(onError.toString());
      toast(onError.toString());
    });

    appStore.setLoading(false);
  }

  Future getData() async {
    getCategory();
    getAttribute();
    getUpSellsId();
    getGroupProductId();
  }

  void cat({int? id, String? name, String? slug}) {
    var listing = Categories();
    listing.id = id;
    listing.name = name;
    listing.slug = slug;
    category.add(listing);
  }

  void getCategory() {
    selectedCategories.clear();
  }

  void getAttribute() {
    selectedAttributes.clear();
    attributes.forEach((element) {
      var selectedAttribute = PAttributes();
      List<String?> selectedOption = [];

      selectedAttribute.id = element.id;
      selectedAttribute.name = element.name;
      selectedAttribute.position = 0;
      selectedAttribute.visible = element.visible;
      selectedAttribute.variation = element.variation;
      selectedAttribute.attributeResponse = element.option;
      element.option!.forEach((element) {
        selectedOption.add(element.name);
      });

      selectedAttribute.options = selectedOption;
      selectedAttributes.add(selectedAttribute);
    });
  }

  void getUpSellsId() {
    upSells.forEach((element) {
      upSellsId.add(element.id);
    });
  }

  void getGroupProductId() {
    grpProduct.forEach((element) {
      groupProductId.add(element.id);
    });
  }

  Future fetchAllAttributesTerms(id) async {
    await getAllAttributeTerms(id).then((res) {
      if (!mounted) return;

      setState(() {
        Iterable mAttributeTerms = res;
        mAttributeTermsModel = mAttributeTerms.map((model) => AttributeTermsResponse.fromJson(model)).toList();
        if (mAttributeModel.isEmpty) {
          mErrorMsg = ('no_data_found'.translate);
        } else {
          mErrorMsg = '';
        }
      });
    }).catchError((error) {
      if (!mounted) return;
      setState(() {
        mErrorMsg = error.toString();
      });
    });
  }

  Future fetchCategoryData() async {
    appStore.setLoading(true);

    await getAllCategory().then((res) {
      log(res);

      if (!mounted) return;
      Iterable mCategory = res;
      mCategoryModel = mCategory.map((model) => CategoryResponse.fromJson(model)).toList();
      if (mCategoryModel.isEmpty) {
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

    appStore.setLoading(false);
  }

  Future fetchAllAttributes() async {
    await getAllAttribute().then((res) {
      if (!mounted) return;

      Iterable mAttribute = res;
      mAttributeModel = mAttribute.map((model) => AttributeResponseModel.fromJson(model)).toList();

      if (mAttributeModel.isEmpty) {
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

  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  Future<void> getAllCategoryList() async {
    appStore.setLoading(true);

    await getAllCategory(page: 1).then((res) async {
      if (page == 1) categoryData.clear();

      categoryData.addAll(res);

      setState(() {});
    }).catchError((e) {
      log(e.toString());
    });

    appStore.setLoading(false);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isUpdate == true)
      setStatusBarColor(Colors.transparent);
    else
      setStatusBarColor(primaryColor);
  }

  @override
  Widget build(BuildContext context) {
    Widget mProductInfo() {
      return Column(
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("lbl_product_information".translate.toUpperCase(), style: boldTextStyle(letterSpacing: 1, size: 20)),
                24.height,
                CommonTextFormField(
                  labelText: "lbl_product_name".translate,
                  focusNode: pNameFocus,
                  mController: pNameCont,
                  validator: (String? s) {
                    if (s!.trim().isEmpty) return 'productName_required'.translate;
                    return null;
                  },
                ),
                16.height,
                CommonTextFormField(
                  labelText: "lbl_product_regular_price".translate,
                  textInputType: TextInputType.numberWithOptions(),
                  focusNode: pRPriceFocus,
                  mController: pRPriceCont,
                  validator: (String? s) {
                    if (s!.trim().isEmpty) return 'productPrice_required'.translate;
                    if (s.trim().isNotEmpty && !s.trim().isDigit()) return 'amount_InValid'.translate;
                    return null;
                  },
                ),
                16.height,
                Row(
                  children: [
                    CommonTextFormField(
                      labelText: "lbl_product_sale_price".translate,
                      textInputType: TextInputType.number,
                      focusNode: pSPriceFocus,
                      mController: pSPriceCont,
                      validator: (String? s) {
                        if (s!.trim().isNotEmpty && !s.trim().isDigit()) return 'amount_InValid'.translate;
                        if (s.trim().isNotEmpty && int.parse(pRPriceCont.text.trim()) <= int.parse(s.trim())) return 'sale_price_msg'.translate;
                        return null;
                      },
                    ).expand(),
                    10.width,
                    Text('lbl_schedule_date'.translate, style: boldTextStyle(size: 14, color: greenColor)).onTap(() {
                      scheduleTime = !scheduleTime;
                      setState(() {});
                    })
                  ],
                ),
                16.height,
                scheduleTime
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('lbl_sale_schedule_date'.translate, style: boldTextStyle()).paddingLeft(4),
                          10.height,
                          CommonTextFormField(
                            labelText: 'hint_fromDate'.translate,
                            onPressed: () {
                              _selectFromDate(context);
                            },
                            textInputType: TextInputType.datetime,
                            focusNode: pSFromTimeFocus,
                            readOnly: true,
                            mController: pSFromTimeCont,
                            suffixIcon: Icon(Icons.date_range, color: appStore.iconColor),
                          ),
                          10.height,
                          CommonTextFormField(
                            labelText: 'hint_toDate'.translate,
                            onPressed: () {
                              _selectToDate(context);
                            },
                            textInputType: TextInputType.datetime,
                            focusNode: pSToTimeFocus,
                            readOnly: true,
                            mController: pSToTimeCont,
                            suffixIcon: Icon(Icons.date_range, color: appStore.iconColor),
                          ),
                        ],
                      ).paddingBottom(16)
                    : SizedBox(),
                CommonTextFormField(
                  labelText: "lbl_product_description".translate,
                  maxLine: 5,
                  minLine: 5,
                  textInputType: TextInputType.multiline,
                  focusNode: pDescFocus,
                  mController: pDescCont,
                ),
                16.height,
                CommonTextFormField(
                    labelText: "lbl_short_product_description".translate, maxLine: 5, minLine: 5, textInputType: TextInputType.multiline, focusNode: pShortDescFocus, mController: pShortDescCont),
                16.height,
                if (pStatusCont.toString().isNotEmpty)
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonFormField<String>(
                      value: pStatusCont,
                      dropdownColor: context.scaffoldBackgroundColor,
                      decoration: InputDecoration.collapsed(hintText: null),

                      hint: Text('select_status'.translate, style: primaryTextStyle()),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(child: Text('Draft', style: primaryTextStyle()), value: 'draft'),
                        DropdownMenuItem(child: Text('Pending', style: primaryTextStyle()), value: 'pending'),
                        DropdownMenuItem(child: Text('Publish', style: primaryTextStyle()), value: 'publish'),
                      ],
                      onChanged: (String? value) {
                        pStatusCont = value;
                        setState(() {});
                      },
                    ),
                  ),
                16.height,
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                  child: DropdownButtonFormField<CategoryResponse>(
                    dropdownColor: context.scaffoldBackgroundColor,
                    decoration: InputDecoration.collapsed(hintText: null),
                    hint: Text('lbl_select_category'.translate, style: primaryTextStyle()),
                    isExpanded: true,
                    value: pCategoryCont,
                    items: categoryData.map((CategoryResponse e) {
                      return DropdownMenuItem<CategoryResponse>(
                        value: e,
                        child: Text(parseHtmlString(e.name.validate()), style: primaryTextStyle()),
                      );
                    }).toList(),
                    onChanged: (CategoryResponse? value) async {
                      pCategoryCont = value;
                      cat(id: value!.id, name: value.name, slug: value.slug);
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: context.width(),
                  decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('lbl_selected_category'.translate, style: boldTextStyle()).paddingOnly(left: 10, top: 8, bottom: 0).center(),
                      Divider(color: Colors.black),
                      Wrap(
                        children: selectedCategories.map((e) {
                          return Container(
                            width: context.width() * 0.4,
                            child: UL(
                              children: [
                                Text(e, style: primaryTextStyle()),
                              ],
                            ),
                          );
                        }).toList(),
                      ).paddingLeft(8).paddingBottom(8)
                    ],
                  ),
                ).visible(selectedCategories.isNotEmpty).paddingTop(8),
                16.height,
                Container(
                  width: context.width(),
                  decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lbl_product_image'.translate, style: primaryTextStyle(letterSpacing: 1)),
                          Icon(Icons.camera_alt).onTap(() async {
                            List<Images1>? res = await MediaImageList().launch(context);
                            if (res != null) {
                              log(res.length);
                              images.addAll(res);
                            }

                            /// Id Means media Image id..
                            images.forEach((element) {
                              selectImg.add({'id': element.id});
                            });
                            setState(() {});
                          })
                        ],
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 16,
                        semanticChildCount: 8,
                        padding: EdgeInsets.only(left: 6, right: 6, top: 12, bottom: 8),
                        children: List.generate(
                          images.length,
                          (index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                cachedImage(images[index].src.validate(), width: 300, height: 300, fit: BoxFit.cover).cornerRadiusWithClipRRect(5),
                                Positioned(
                                  right: -5,
                                  top: -8,
                                  child: Icon(AntDesign.closecircleo, size: 20, color: Colors.red).onTap(() {
                                    images.remove(images[index]);
                                    setState(() {});
                                  }),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                16.height,
                Text('lbl_product_type'.translate, style: boldTextStyle()).paddingLeft(6),
                5.height,
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                  child: DropdownButtonFormField<String>(
                    focusNode: pTypeFocus,
                    value: pTypeCont,
                    dropdownColor: context.scaffoldBackgroundColor,
                    decoration: InputDecoration.collapsed(hintText: null),
                    isExpanded: true,
                    items: productType.map((e) => DropdownMenuItem(value: e, child: Text(e, style: primaryTextStyle()))).toList(),
                    onChanged: (String? value) {
                      pTypeCont = value;
                      setState(() {});
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextIcon(
                    text: 'lbl_adavanced_option'.translate,
                    textStyle: boldTextStyle(),
                    prefix: Icon(!isAdvance ? Icons.add : Icons.horizontal_rule_outlined, size: 15, color: appStore.iconColor),
                    onTap: () {
                      isAdvance = !isAdvance;
                      setState(() {});
                    },
                  ).paddingOnly(top: 8),
                ),
                isAdvance
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (pTypeCont == 'grouped')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    16.height,
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text('lbl_grouped'.translate, style: primaryTextStyle()),
                                              InkWell(
                                                onTap: () async {
                                                  List<ProductDetailResponse1> result = await UpSellsScreen(isGroup: true, grpProduct: grpProduct).launch(context);
                                                  grpProduct = result;
                                                  setState(() {});
                                                  log("Result ${result.length}");
                                                },

                                                child: Text('lbl_add_product'.translate, style: secondaryTextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                              )
                                            ],
                                          ),
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            runSpacing: 10,
                                            spacing: 10,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              grpProduct.length == 0 ? 0 : grpProduct.length,
                                              (index) => Chip(
                                                onDeleted: () {
                                                  grpProduct[index].isCheck = !grpProduct[index].isCheck;
                                                  grpProduct.remove(grpProduct[index]);
                                                  setState(() {});
                                                },
                                                deleteIconColor: Colors.red,
                                                deleteIcon: Icon(Icons.cancel, color: Colors.blue),
                                                label: Text(grpProduct[index].name, maxLines: 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          (pTypeCont == 'external')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('lbl_general'.translate, style: boldTextStyle()).paddingOnly(left: 4, bottom: 6),
                                    Container(
                                      width: context.width(),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: iconColorSecondary, width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          CommonTextFormField(
                                            labelText: "lbl_product_url".translate,
                                            maxLine: 5,
                                            focusNode: pExternalUrlFocus,
                                            mController: pExternalUrlCont,
                                            minLine: 1,
                                            prefixText: "https:// ",
                                            suffixIcon: Tooltip(
                                              message: "msg_external_url".translate,
                                              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                              child: Icon(Icons.info, color: appStore.iconColor),
                                            ),
                                          ),
                                          16.height,
                                          CommonTextFormField(
                                            labelText: "lbl_button_text".translate,
                                            focusNode: pButtonTextFocus,
                                            mController: pButtonTextCont,
                                            suffixIcon: Tooltip(
                                              message: "msg_link_external_url".translate,
                                              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                              child: Icon(Icons.info, color: appStore.iconColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : 0.height,
                          (pTypeCont == 'grouped' || pTypeCont == 'simple' || pTypeCont == 'external')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    16.height,
                                    Text('lbl_linked_product'.translate, style: boldTextStyle()).paddingLeft(4),
                                    5.height,
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text('lbl_upsell'.translate, style: primaryTextStyle()),
                                              InkWell(
                                                onTap: () async {
                                                  List<ProductDetailResponse1> result = await UpSellsScreen(isGroup: false, grpProduct: grpProduct).launch(context);
                                                  upSells = result;
                                                  setState(() {});
                                                  log("Result ${result.length}");
                                                },

                                                child: Text('lbl_add_product'.translate, style: secondaryTextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                              )
                                            ],
                                          ),
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            alignment: WrapAlignment.start,
                                            runSpacing: 8,
                                            spacing: 8,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              upSells.length == null ? 0 : upSells.length,
                                              (index) => Chip(
                                                backgroundColor: color.primaryColor.withOpacity(0.07),
                                                onDeleted: () {
                                                  upSells[index].isCheck = !upSells[index].isCheck;
                                                  upSells.remove(upSells[index]);
                                                  setState(() {});
                                                },
                                                deleteIconColor: Colors.red,
                                                deleteIcon: Icon(Icons.cancel, color: Colors.blue),
                                                label: Text(upSells[index].name, maxLines: 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : 0.height,
                          16.height,
                          (pTypeCont == 'grouped' || pTypeCont == 'simple' || pTypeCont == 'external' || pTypeCont == 'variable')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('lbl_attributes'.translate, style: boldTextStyle()).paddingLeft(4),
                                    5.height,
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                                      child: DropdownButtonFormField<AttributeResponseModel>(
                                        focusNode: pTypeFocus,
                                        dropdownColor: context.scaffoldBackgroundColor,
                                        value: attributeResponse,
                                        decoration: InputDecoration.collapsed(hintText: null),
                                        hint: Text('lbl_select_attributes'.translate, style: primaryTextStyle()),
                                        isExpanded: true,
                                        items: mAttributeModel.map((AttributeResponseModel e) {
                                          // hideKeyboard(context);
                                          return DropdownMenuItem<AttributeResponseModel>(
                                            value: e,
                                            child: Text(e.name.validate(), style: primaryTextStyle()),
                                          );
                                        }).toList(),
                                        onChanged: (AttributeResponseModel? value) async {
                                          attributeResponse = value;
                                          await fetchAllAttributesTerms(value?.id.validate());
                                          if (attributes.isEmpty) {
                                            mAttributeName.add(value!);
                                            attributes.insert(0, AttributeSection(id: value.id, name: value.name, option: mAttributeTermsModel));
                                            value.isSelected = true;
                                          } else {
                                            mAttributeName.forEach((element) {
                                              if (element.isSelected == value!.isSelected) {
                                                toast("msg_select_attributes".translate);
                                              } else {
                                                value.isSelected = true;
                                                mAttributeName.add(value);
                                                attributes.insert(0, AttributeSection(id: value.id, name: value.name, option: mAttributeTermsModel));
                                              }
                                            });
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    16.height,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: attributes.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                              margin: EdgeInsets.only(bottom: 8),
                                              decoration: BoxDecoration(
                                                color: getColorFromHex(colorArray[index % colorArray.length]).withOpacity(0.05),
                                                border: Border.all(color: iconColorSecondary, width: 1),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(attributes[index].name.validate(), style: boldTextStyle(size: 18, color: color.primaryColor)),
                                                  16.height,

                                                  Text('lbl_values'.translate, style: boldTextStyle(size: 14)).paddingLeft(6),
                                                  4.height,
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
                                                    width: context.width(),
                                                    decoration: boxDecorationWithRoundedCorners(
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: iconColorSecondary, width: 1),
                                                      backgroundColor: Colors.transparent,
                                                    ),
                                                    child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.start,
                                                      runSpacing: 10,
                                                      spacing: 10,
                                                      runAlignment: WrapAlignment.start,
                                                      direction: Axis.horizontal,
                                                      children: List.generate(
                                                        attributes[index].option.validate().isEmpty ? 0 : attributes[index].option!.length,
                                                        (i) => Chip(
                                                          backgroundColor: color.colorAccent.withOpacity(0.09),
                                                          padding: EdgeInsets.all(0),
                                                          onDeleted: () {
                                                            attributes[index].option!.remove(attributes[index].option![i]);
                                                            setState(() {});
                                                          },
                                                          deleteIconColor: Colors.red,
                                                          deleteIcon: Icon(Icons.cancel, color: Colors.black),
                                                          label: Text(attributes[index].option![i].name.validate(), style: primaryTextStyle(color: color.colorAccent)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                            margin: EdgeInsets.symmetric(vertical: 4),
                                                            decoration: boxDecoration(context, bgColor: color.primaryColor.withOpacity(0.5)),
                                                            child: Text('Add New', style: secondaryTextStyle(color: white)))
                                                        .onTap(() {
                                                      showConfirmDialogCustom(
                                                        context,
                                                        title: "Add new attribute",
                                                        primaryColor: primaryColor,
                                                        customCenterWidget: AppTextField(
                                                          controller: attributeCont,
                                                          textFieldType: TextFieldType.NAME,
                                                          cursorColor: appStore.isDarkModeOn ? white : black,
                                                          decoration: inputDecoration(context, "lbl_Description".translate),
                                                          keyboardType: TextInputType.text,
                                                          maxLines: 5,
                                                        ).paddingAll(12),
                                                        onAccept: (_) async {
                                                          mAttributeTermsModel.add(AttributeTermsResponse(name: attributeCont.text));

                                                          setState(() {});
                                                          attributeCont.clear();
                                                        },
                                                        dialogType: DialogType.CONFIRMATION,
                                                        negativeText: 'lbl_cancel'.translate,
                                                        positiveText: "Add",
                                                      );
                                                    }),
                                                  ),
                                                  CheckboxListTile(
                                                    dense: true,
                                                    contentPadding: EdgeInsets.all(0),
                                                    value: attributes[index].visible,
                                                    title: Text('lbl_visiable_product_page'.translate, style: primaryTextStyle()),
                                                    onChanged: (v) {
                                                      attributes[index].visible = !attributes[index].visible!;
                                                      setState(() {});
                                                    },
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                  ),
                                                  CheckboxListTile(
                                                    dense: true,
                                                    contentPadding: EdgeInsets.all(0),
                                                    value: attributes[index].variation,
                                                    selectedTileColor: appStore.scaffoldBackground,

                                                    title: Text('lbl_used_variations'.translate, style: primaryTextStyle()),
                                                    onChanged: (v) {
                                                      attributes[index].variation = !attributes[index].variation!;
                                                      setState(() {});
                                                    },
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Text('lbl_remove_attribute'.translate, style: primaryTextStyle(color: Colors.red, size: 12)).onTap(() {
                                                      showConfirmDialogCustom(context, primaryColor: primaryColor, onAccept: (c) {
                                                        attributes.remove(attributes[index]);
                                                        finish(context);
                                                        setState(() {});
                                                        mAttributeName.removeAt(index);
                                                      });
                                                    }),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      )
                    : SizedBox()
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      key: globalKey,
      backgroundColor: appStore.scaffoldBackground,
      appBar: appBarWidget(
        "",
        titleWidget: Text("add_product".translate, maxLines: 1, style: boldTextStyle(color: white), overflow: TextOverflow.ellipsis),
        elevation: 10,
        color: primaryColor,
        backWidget: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(Icons.arrow_back, color: white),
        ),
        actions: [
          Row(
            children: [
              switchValue ? Text('lbl_stock'.translate, style: primaryTextStyle(color: Colors.green)) : Text('lbl_out_of_stock'.translate, style: primaryTextStyle(color: Colors.red)),
              Switch(
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.redAccent.withOpacity(0.4),
                activeColor: color.appGreenColor,
                value: switchValue,
                onChanged: (_value) {
                  log(switchValue);
                  switchValue = _value;
                  setState(() {});
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: color.primaryColor,

        child: Text(widget.isUpdate == false ? "add_product".translate : "update_product".translate, style: boldTextStyle(size: 20, color: Colors.white)).center(),
      ).onTap(() {
        setState(() {});
        if (widget.isUpdate == false) {
          addNewProduct();
        } else {
          updateExistingProduct();
        }
      }),
      body: Stack(
        children: [
          SingleChildScrollView(padding: EdgeInsets.all(16), child: mProductInfo()),
          Observer(builder: (_) => loading().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
