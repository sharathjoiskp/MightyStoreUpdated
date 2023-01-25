import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mightyAdmin/models/FinalVariationData.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/models/ProductResponse.dart';
import 'package:mightyAdmin/models/VariationResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'MediaImageList.dart';

class ProductVariations extends StatefulWidget {
  final List<PAttributes>? attributes;
  final ProductDetailResponse1? singleProductResponse;
  final int? id;
  final String? name;

  ProductVariations({this.attributes, this.id, this.name, this.singleProductResponse});

  @override
  _ProductVariationsState createState() => _ProductVariationsState();
}

class _ProductVariationsState extends State<ProductVariations> {
  List<VariationResponse>? variationResponse = [];
  List<String> variationOption = [];
  List<String> stockStatus = [];
  List<List<List<AttributeList>>> mainList = [];
  String? selectedVariationOption;
  String? selected;
  String? selectedValue;
  bool isLoading = false;
  bool scheduleTime = false;
  List getVariationList = [];
  List<Images1> images = [];
  List<Map<String, dynamic>> selectImg = [];

  List<VariationProduct> vatiationProduct = [];
  List<PAttributes> attribute = [];
  List<String> colorArray = ['#000000', '#ccd5e1'];

  TextEditingController rPriceCont = TextEditingController();
  TextEditingController sPriceCont = TextEditingController();
  TextEditingController pSFromTimeCont = TextEditingController();
  TextEditingController pSToTimeCont = TextEditingController();
  TextEditingController pDescCont = TextEditingController();
  FocusNode pSFromTimeFocus = FocusNode();
  FocusNode pSToTimeFocus = FocusNode();

  DateTime? selectedToDate = DateTime.now();
  DateTime? selectedFromDate = DateTime.now();

  FocusNode? rPriceFocus;
  FocusNode? sPriceFocus;
  FocusNode? selectedStatusFocus;

  List<Variation> variationList = [];

  @override
  void initState() {
    print("inside: ${widget.id}");
    super.initState();
    init();
  }

  init() async {
    fetchAllVariations(widget.id);
    variationOption.add("Add variation");
    variationOption.add("Delete variation");
    stockStatus.add('In stock');
    stockStatus.add('Out of Stock');
    stockStatus.add('out of rePurchasable');
    attribute.addAll(widget.attributes!);
    //print("attribute : ${jsonEncode(attribute)}");
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
        firstDate: selectedFromDate!,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedFromDate) print(picked);
    selectedFromDate = picked;
    String date = '${selectedFromDate!.day}-${selectedFromDate!.month}-${selectedFromDate!.year}';
    pSFromTimeCont.text = date;
    setState(() {});
  }

  fetchAllVariations(pid) async {
    await getVariation(pid).then((value) {
      variationResponse = value;
      variationResponse!.forEach((element) {
        getVariationList.add(element);
      });
      toast("pid=---------------------->:" + getVariationList.first, print: true);
    }).catchError((e) {
      log("fail to load :" + e.toString());
    });
  }

  createVariationApi() async {
    List<FinalVariationData> finalVariationList = [];
    for (int i = 0; i < variationList.length; i++) {
      FinalVariationData fVariation = FinalVariationData(attributes: []);
      fVariation.regularPrice = rPriceCont.text;
      fVariation.salePrice = sPriceCont.text;
      fVariation.description = pDescCont.text;
      fVariation.dateOnSaleTo = pSToTimeCont.text;
      fVariation.images = images;
      fVariation.dateOnSaleFrom = pSFromTimeCont.text;

      fVariation.status = variationList[i].selectedStatus;
      if (fVariation.status!.toLowerCase() == "In stock".toLowerCase()) {
        fVariation.status = "instock";
      } else if (fVariation.status!.toLowerCase() == "Out of Stock".toLowerCase()) {
        fVariation.status = "outofstock";
      } else if (fVariation.status!.toLowerCase() == "Out of rePurchasable".toLowerCase()) {
        fVariation.status = "onbackorder";
      }
      for (int j = 0; j < variationList[i].variationList.length; j++) {
        VariationAttributeData attributeData = VariationAttributeData();
        attributeData.id = variationList[i].variationList[j][0].id;
        attributeData.name = variationList[i].variationList[j][0].name;
        attributeData.option = variationList[i].variationList[j][0].selectedValue;

        fVariation.attributes!.add(attributeData);
      }

      finalVariationList.add(fVariation);
    }
    print("Final Data: " + jsonEncode(finalVariationList));
    // TODO Loop until finalVariationList and call add variaction api
    print("-------->>>>>${widget.id}");
    print("------->>123${widget.name}");
    hideKeyboard(context);
    print("inside: ${widget.id}");
    print("lbl_Hello ".translate + jsonEncode(finalVariationList));
    setState(() {
      isLoading = true;
    });
    var request = {
      'create': finalVariationList,
    };
    print("Hello $request");
    createVariation(widget.id, request).then((value) {
      toast('lbl_create_variation'.translate);
      finish(context, true);
      finish(context, true);
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      print(onError.toString());
    });
  }

  deleteVariation() {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        titleWidget: Text('product_variation'.translate, style: boldTextStyle(color: white)),
        elevation: 10,
        color: context.primaryColor,
        backWidget: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(Icons.arrow_back, color: white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(color: iconColorSecondary, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedVariationOption,
                  decoration: InputDecoration.collapsed(hintText: null),
                  hint: Text('select_variation'.translate, style: primaryTextStyle()),
                  isExpanded: true,
                  items: variationOption.map((e) => DropdownMenuItem<String>(child: Text(e), value: e)).toList(),
                  onChanged: (String? value) {
                    selectedVariationOption = value;
                    setState(() {});
                  },
                ),
              ).expand(),
              10.width,
              OutlinedButton(
                onPressed: () {
                  if (selectedVariationOption == 'Add variation') {
                    List<List<VariationAttributeData>> innerList = [];
                    for (int i = 0; i < attribute.length; i++) {
                      List<VariationAttributeData> list1 = [];
                      for (int j = 0; j < attribute[i].attributeResponse!.length; j++) {
                        if (j == 0) {
                          list1.add(
                            VariationAttributeData(
                                id: attribute[i].id,
                                option: attribute[i].attributeResponse![j].name,
                                name: attribute[i].name,
                                selectedValue: attribute[i].attributeResponse![j].name,
                                selectedId: attribute[i].attributeResponse![j].id),
                          );
                        } else {
                          list1.add(
                            VariationAttributeData(
                              id: attribute[i].id,
                              name: attribute[i].name,
                              option: attribute[i].attributeResponse![j].name,
                            ),
                          );
                        }
                      }
                      innerList.addAll([list1]);
                    }
                    Variation vlist = Variation();
                    vlist.selectedStatus = stockStatus[0];
                    vlist.variationList.addAll(innerList);
                    variationList.insert(0, vlist);

                    setState(() {});
                  } else if (selectedVariationOption == 'Delete variation') {
                    variationList.clear();
                    setState(() {});
                    finish(context, true);
                    finish(context, true);
                  } else {
                    toast('lbl_select_variation'.translate);
                    setState(() {});
                  }
                },
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), side: BorderSide(width: 2, color: Colors.green)),

                ///TODO missing key
                child: Text('Go', style: boldTextStyle(color: Colors.green)).center().paddingAll(12),
              )
            ],
          ),
          16.height,
          Container(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return 16.height;
              },
              itemCount: variationList.length.validate(value: 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: getColorFromHex(colorArray[index % colorArray.length]).withOpacity(0.1),
                    border: Border.all(color: iconColorSecondary, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///TODO keyMissing
                      Text('Variation ${index + 1}', style: boldTextStyle()).center(),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        alignment: WrapAlignment.start,
                        spacing: 1,
                        children: List.generate(
                          variationList[index].variationList.length,
                          (i) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: boxDecoration(context, radius: 8),
                              child: DropdownButton(
                                value: variationList[index].variationList[i][0].selectedValue,
                                underline: SizedBox(),
                                items: variationList[index].variationList[i].map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.option!),
                                    value: e.option,
                                  );
                                }).toList(),
                                onChanged: (dynamic value) {
                                  variationList[index].variationList[i][0].selectedValue = value;

                                  /* attribute.forEach((element) {
                                    element.attributeResponse.forEach((e) {
                                      if (e.name == value) {
                                        return variationList[index].variationList[i][0].selectedId = e.id;
                                      }
                                    });
                                  });*/
                                  setState(() {});
                                },
                              ).paddingRight(10),
                            );
                          },
                        ).toList(),
                      ),
                      16.height,

                      ///TODO add key
                      CommonTextFormField(
                        mController: rPriceCont,
                        labelText: 'productPrice_required'.translate,
                        textInputType: TextInputType.number,
                        validator: (String? s) {
                          if (s!.trim().isEmpty) return 'productPrice_required'.translate;
                          if (s.trim().isNotEmpty && !s.trim().isDigit()) return 'amount_InValid'.translate;
                          return null;
                        },
                      ),
                      16.height,
                      Row(
                        children: [
                          CommonTextFormField(mController: sPriceCont, labelText: 'sale_price'.translate, textInputType: TextInputType.number).expand(),
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
                                        child: Icon(AntDesign.closecircleo, size: 20).onTap(() {
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
                      CommonTextFormField(
                        labelText: "lbl_product_description".translate,
                        maxLine: 5,
                        minLine: 5,
                        textInputType: TextInputType.multiline,
                        mController: pDescCont,
                      ),
                      16.height,
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(border: Border.all(color: iconColorSecondary, width: 1), borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonFormField<String>(
                          value: variationList[index].selectedStatus,
                          decoration: InputDecoration.collapsed(hintText: null),

                          ///TODO key missing
                          hint: Text('select_status'.translate, style: primaryTextStyle()),
                          isExpanded: true,
                          items: stockStatus.map((e) => DropdownMenuItem<String>(child: Text(e), value: e)).toList(),
                          onChanged: (String? value) {
                            hideKeyboard(context);
                            variationList[index].selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      16.height,
                      Container(
                        alignment: Alignment.bottomRight,

                        ///TODO key Missing
                        child: Text('remove_variation'.translate, style: primaryTextStyle(color: Colors.red, size: 12)).onTap(() {
                          showConfirmDialogCustom(context, onAccept: (_) {
                            variationList.remove(variationList[index]);
                            setState(() {});
                            finish(context);
                          }, dialogType: DialogType.DELETE, negativeText: 'lbl_cancel'.translate, positiveText: 'lbl_Yes'.translate);

                          setState(() {});
                        }),
                      )
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.check, color: white),
        isExtended: true,
        onPressed: () {
          createVariationApi();

          ///wp-json/wc/v3/products/<product_id>/variations
        },
      ),
    );
  }
}

class VariationProduct {
  double? price;
  double? salesPrice;
  String? status;
  int? selectedId;
  List<String>? stockStatus;
  List<String>? attribute;
  String? selectedStockStatus;
  String? selectedAttribute;

  VariationProduct({
    this.price,
    this.salesPrice,
    this.status,
    this.attribute,
    this.selectedId,
    this.stockStatus,
    this.selectedStockStatus,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['price'] = this.price;
    data['salesPrice'] = this.salesPrice;
    data['status'] = this.status;
    data['slectedid'] = this.selectedId;
    data['selectedAttribute'] = this.selectedAttribute;
    return data;
  }
}

class Variation {
  List<List<VariationAttributeData>> variationList = [];
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  String? selectedStatus = "";
}

class AttributeList {
  TextEditingController? rPriceCont = TextEditingController();
  TextEditingController? sPriceCont = TextEditingController();
  String? selectedStatus;
  String value;
  String name;
  String selectedValue;
  int? selectedId;

  AttributeList({
    required this.value,
    required this.name,
    this.selectedValue = "",
    this.selectedId,
    this.sPriceCont,
    this.rPriceCont,
    this.selectedStatus,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['value'] = this.value;
    data['name'] = this.name;
    data['selectedValue'] = this.selectedValue;
    return data;
  }
}
