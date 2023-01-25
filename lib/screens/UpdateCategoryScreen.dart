import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/CategoryResponse.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MediaImageList.dart';

// ignore: must_be_immutable
class UpdateCategoryScreen extends StatefulWidget {
  static String tag = '/EditCategoryScreen';

  final List<CategoryResponse>? categoryList;
  CategoryResponse? categoryData;
  bool isEdit;

  UpdateCategoryScreen({this.categoryData, this.categoryList, this.isEdit = true});

  @override
  UpdateCategoryScreenState createState() => UpdateCategoryScreenState();
}

class UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  TextEditingController categoryNameCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  var parentCategoryCont = TextEditingController();

  FocusNode categoryFocus = FocusNode();
  FocusNode parentCategoryFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode displayTypeFocus = FocusNode();

  List<Images1> images = [];
  Map<String, dynamic> selectImg = Map<String, dynamic>();

  List<CategoryResponse> categoryData = [];

  //List displayType = ['Default', 'Products', 'SubCategories', 'Both'];

  CategoryResponse? pCategoryCont;

  int? parent = 0;

  //String displayTypeCont;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (widget.isEdit) {
      widget.categoryList!.forEach((element) {
        if (element.name == parseHtmlString(widget.categoryData!.name.validate())) {
          log('Parent :- ${element.name.validate() + element.id.toString()}');
          pCategoryCont = element;
          parent = element.id;
        }
      });

      categoryNameCont.text = parseHtmlString(widget.categoryData!.name.validate());
      descriptionCont.text = parseHtmlString(widget.categoryData!.description.validate());
      parent = widget.categoryData!.parent.validate();
    }
  }

  Future<void> updateCategories() async {
    var request = {
      'name': categoryNameCont.text,
      'parent': parent,
      'description': descriptionCont.text,
      'image': selectImg.isNotEmpty ? selectImg : widget.categoryData!.image,
    };

    appStore.setLoading(true);

    updateCategory(widget.categoryData!.id, request).then((res) {
      toast('lbl_update_successfully'.translate);

      widget.categoryData!.name = request['name'] as String?;
      widget.categoryData!.description = request['description'] as String?;

      finish(context, true);
    }).catchError((error) {
      log(error.toString());
      toast(error.toString().validate());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  Future<void> addCategories() async {
    var request = {
      'name': categoryNameCont.text,
      'parent': parent,
      'description': descriptionCont.text,
      'image': selectImg,
    };

    appStore.setLoading(true);

    addCategory(request).then((res) {
      toast('lbl_add_category_successfully'.translate);
      widget.categoryList!.add(res);

      finish(context, true);
    }).catchError((error) {
      log(error.toString());
      toast(error.toString().validate());
    }).whenComplete(() {
      LiveStream().emit(ADD_CATEGORY, true);
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
      appBar: appBarWidget(widget.isEdit ? "lbl_Update_Category".translate : "lbl_Add_Category".translate, color: primaryColor, textColor: Colors.white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                AppTextField(
                  controller: categoryNameCont,
                  textFieldType: TextFieldType.NAME,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, "lbl_Category_Name".translate),
                ),
                16.height,
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: iconColorSecondary, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonFormField<CategoryResponse>(
                    dropdownColor: appStore.scaffoldBackground,
                    decoration: InputDecoration.collapsed(hintText: null),
                    hint: Text("lbl_Select_Parent_Category".translate, style: secondaryTextStyle()),
                    isExpanded: true,
                    value: pCategoryCont,
                    focusNode: parentCategoryFocus,
                    items: widget.categoryList!.map((CategoryResponse e) {
                      return DropdownMenuItem<CategoryResponse>(
                        value: e,
                        child: parent == e.parent ? Text(parseHtmlString(e.name.validate()), style: primaryTextStyle()) : Text(parseHtmlString(e.name.validate()), style: primaryTextStyle()),
                      );
                    }).toList(),
                    onChanged: (CategoryResponse? value) async {
                      pCategoryCont = value;
                      widget.categoryList!.forEach((element) {
                        if (element.name == value!.name) {
                          log('Parent :- ${element.name.validate() + element.id.toString()}');
                          parent = element.id;
                        }
                      });
                      setState(() {});
                    },
                  ),
                ),
                16.height,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: boxDecoration(context, radius: 10, color: context.dividerColor),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lbl_product_image'.translate, style: primaryTextStyle()),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                      cachedImage(
                        widget.categoryData!.image != null ? widget.categoryData!.image!.src.validate() : "",
                        width: context.width(),
                        height: 150,
                        fit: BoxFit.cover,
                      ).cornerRadiusWithClipRRect(6).paddingOnly(top: 16, bottom: 16)
                    ],
                  ),
                ).onTap(() async {
                  List<Images1>? res = await MediaImageList().launch(context);
                  if (res != null) {
                    images.addAll(res);
                  }

                  /// Id Means media Image id..
                  images.forEach((element) {
                    selectImg['src'] = element.src;
                  });
                  setState(() {});
                }),
                16.height,
                AppTextField(
                  controller: descriptionCont,
                  focus: descriptionFocus,
                  textFieldType: TextFieldType.NAME,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, "lbl_Description".translate),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                16.height,
                AppButton(
                  text: widget.isEdit ? "lbl_Update".translate : "lbl_Add".translate,
                  color: primaryColor,
                  textColor: white,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);
                    if (widget.isEdit) {
                      updateCategories();
                    } else {
                      addCategories();
                    }
                  },
                ),
                16.height,
              ],
            ),
          ),
          Observer(builder: (_) => loading().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
