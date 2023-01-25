import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/AttributeModel.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/UpdateTermScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class ProductTermWidget extends StatefulWidget {
  static String tag = '/ProductAttributeTermWidget';

  AttributeModel? data;
  final int? attributeId;
  final Function(int?)? onDelete;
  final Function? onUpdate;

  ProductTermWidget({this.data, this.attributeId, this.onDelete, this.onUpdate});

  @override
  _ProductTermWidgetState createState() => _ProductTermWidgetState();
}

class _ProductTermWidgetState extends State<ProductTermWidget> {
  bool isLoading = false;

  void deleteAttributesTerms() {
    hideKeyboard(context);

    appStore.setLoading(true);

    deleteAttributesTerm(attributeId: widget.attributeId, attributeTermId: widget.data!.id).then((res) {
      toast('successfully_deleted'.translate);

      widget.onDelete?.call(res.id);
    }).catchError((e) {
      log(e.toString());
    }).whenComplete(() {
      LiveStream().emit(REMOVE_ATTRIBUTE_TERMS, true);
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(widget.data!.name!, style: boldTextStyle()).expand(),
          Row(
            children: [
              TextIcon(
                prefix: Icon(Icons.edit, size: 14, color: primaryColor),
                text: 'lbl_Edit'.translate,
                textStyle: primaryTextStyle(color: primaryColor),
                onTap: ()async{
                  bool? res = await UpdateTermScreen(termsData: widget.data, attributeId: widget.attributeId).launch(context);
                  if(res ?? false){
                    setState(() {});
                    widget.onUpdate?.call();
                  }
                },

              ),
              // Text("lbl_Edit".translate, style: primaryTextStyle(color: Colors.blue)).onTap(() async {
              //   bool? res = await UpdateTermScreen(termsData: widget.data, attributeId: widget.attributeId).launch(context);
              //
              //   if (res ?? false) {
              //     setState(() {});
              //     widget.onUpdate?.call();
              //   }
              // }),
              16.width,
              TextIcon(
                prefix:Icon(Icons.delete, size: 14, color: Colors.red),
                text: 'lbl_Delete'.translate,
                textStyle: primaryTextStyle(color: Colors.red),
                onTap: ()async{
                  showConfirmDialogCustom(
                      context,
                      title: "lbl_confirmation_Product_Attributes".translate,
                      onAccept: (_) {
                        deleteAttributesTerms();
                      },
                      dialogType: DialogType.DELETE,
                      positiveText: 'lbl_Delete'.translate,negativeText:'lbl_cancel'.translate

                  );
                },

              ),
              // Text("lbl_Delete".translate, style: primaryTextStyle(color: Colors.red)).onTap(() async {
              //   showConfirmDialogCustom(
              //     context,
              //     title: "lbl_confirmation_Product_Attributes_Terms".translate,
              //     onAccept: () {
              //       deleteAttributesTerms();
              //     },
              //     dialogType: DialogType.DELETE,
              //   );
              // }),
              8.width,
            ],
          ),
        ],
      ),
    );
  }
}
