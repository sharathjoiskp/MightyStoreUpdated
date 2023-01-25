import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/models/AttributeModel.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class UpdateTermScreen extends StatefulWidget {
  static String tag = '/UpdateTermScreen';
  final AttributeModel? termsData;
  final int? attributeId;
  final Function? onUpdate;

  UpdateTermScreen({this.termsData, this.attributeId, this.onUpdate});

  @override
  UpdateTermScreenState createState() => UpdateTermScreenState();
}

class UpdateTermScreenState extends State<UpdateTermScreen> {
  TextEditingController attributeNameCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    attributeNameCont.text = widget.termsData!.name.validate();
  }

  Future<void> updateTerms() async {
    appStore.setLoading(true);

    var request = {'name': attributeNameCont.text};

    await editTerms(request: request, attributeTermId: widget.termsData!.id, attributeId: widget.attributeId).then((res) {
      widget.termsData!.name = attributeNameCont.text.validate();

      toast('lbl_update_successfully'.translate);

      finish(context, true);
    }).catchError((e) {
      toast(e.toString());
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
      appBar: appBarWidget("lbl_Update_Attribute".translate, showBack: true, color: primaryColor, textColor: white),
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
                  decoration: inputDecoration(context, "lbl_Product_Attribute".translate),
                  autoFocus: true,
                ),
                16.height,
                AppButton(
                  text: "lbl_Edit".translate,
                  color: primaryColor,
                  textColor: white,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);

                    updateTerms();
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
