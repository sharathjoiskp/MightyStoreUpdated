import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/models/AttributeModel.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class AddAttributeScreen extends StatefulWidget {
  static String tag = '/AddAttributeScreen';
  final AttributeModel? attributeData;
  final int? attributeId;
  final Function? onUpdate;
  final bool? isUpdate;

  AddAttributeScreen({this.attributeData, this.attributeId, this.onUpdate, this.isUpdate});

  @override
  AddAttributeScreenState createState() => AddAttributeScreenState();
}

class AddAttributeScreenState extends State<AddAttributeScreen> {
  TextEditingController attributeNameCont = TextEditingController();
  TextEditingController slugCont = TextEditingController();

  FocusNode descriptionFocus = FocusNode();
  bool mArchives = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // toast('Back');
    attributeNameCont.text = widget.attributeData!.name.toString();
    slugCont.text = widget.attributeData!.slug.toString();
    mArchives = widget.attributeData!.hasArchives!;
  }

  Future<void> addAttributes() async {
    //var request = {'name': attributeNameCont.text};
    var request = {
      "name": attributeNameCont.text,
      "slug": slugCont.text,
      "type": "select",
      "order_by": "menu_order",
      "has_archives": mArchives,
    };
    appStore.setLoading(true);

    await addAttribute(req: request).then((res) {
      toast('lbl_Add_Attribute_successfully'.translate);

      finish(context, res);
    }).catchError((e) {
      toast("${e['message']}");
    }).whenComplete(() => appStore.setLoading(false));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.isUpdate == true ? "lbl_Update_Attribute".translate : 'lbl_Add_Attribute'.translate, showBack: true, color: primaryColor, textColor: white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                AppTextField(
                  controller: attributeNameCont,
                  textFieldType: TextFieldType.NAME,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, 'lbl_Product_Attribute'.translate),
                  nextFocus: descriptionFocus,
                  autoFocus: true,
                ),
                16.height,
                AppTextField(
                  controller: slugCont,
                  focus: descriptionFocus,
                  textFieldType: TextFieldType.NAME,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, 'lbl_Slug'.translate),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                8.height,
                Row(
                  children: [
                    CustomTheme(
                      child: Checkbox(
                        focusColor: primaryColor,
                        activeColor: primaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: mArchives,
                        onChanged: (bool? value) async {
                          mArchives = !mArchives;
                          setState(() {});
                        },
                      ),
                    ),

                    Text("lbl_eneble".translate, style: secondaryTextStyle()).onTap(() async {
                      mArchives = !mArchives;
                      setState(() {});
                    }),
                  ],
                ),
                16.height,
                AppButton(
                  text: widget.isUpdate == true ? "lbl_Update_Attribute".translate : 'lbl_Add_Attribute'.translate,
                  color: primaryColor,
                  textColor: white,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);

                    addAttributes();
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
