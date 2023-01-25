import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/CustomerResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/UpdateCustomerScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomerItemWidget extends StatefulWidget {
  static String tag = '/CustomerItemWidget';

  final CustomerResponse? data;
  final Function? onUpdate;
  final Function(int?)? onDelete;

  CustomerItemWidget({this.data, this.onUpdate, this.onDelete});

  @override
  CustomerItemWidgetState createState() => CustomerItemWidgetState();
}

class CustomerItemWidgetState extends State<CustomerItemWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> deleteCustomers() async {
    appStore.setLoading(true);

    await deleteCustomer(customerId: widget.data!.id.validate()).then((res) {
      widget.onDelete?.call(res.id);
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() {
      setState(() {});
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cachedImage(widget.data!.avatarUrl, height: 65, width: 65).cornerRadiusWithClipRRect(33),
        12.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${widget.data?.firstName.validate()} ${widget.data?.lastName.validate()}', style: boldTextStyle()).expand(),
                widget.data!.role!.isNotEmpty ? Text('${widget.data?.role.validate().capitalizeFirstLetter()}', style: primaryTextStyle(size: 14)) : SizedBox(),
              ],
            ),
            widget.data!.username!.isNotEmpty
                ? Text(widget.data!.username.validate(), style: widget.data!.firstName!.isNotEmpty && widget.data!.lastName!.isNotEmpty ? primaryTextStyle() : boldTextStyle())
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data!.email!.isNotEmpty ? Text(widget.data!.email.validate(), style: secondaryTextStyle()).expand() : SizedBox(),
                Row(
                  children: [
                    commonEditButtonComponent(
                        color: primaryColor,
                        icon: Icons.edit,
                        onCall: () async {
                          if (isVendor) {
                            toast("admin_toast".translate);
                            return;
                          }
                          bool? res = await UpdateCustomerScreen(customerData: widget.data).launch(context);
                          if (res ?? false) {
                            setState(() {});
                            widget.onUpdate?.call();
                          }
                        }),
                    commonEditButtonComponent(
                        color: redColor,
                        icon: Icons.delete,
                        onCall: () async {
                          if (isVendor) {
                            toast("admin_toast".translate);
                            return;
                          }
                          showConfirmDialogCustom(
                            context,
                            title: "lbl_confirmation_Remove_Customers".translate,
                            onAccept: (_) {
                              deleteCustomers();
                            },
                            dialogType: DialogType.DELETE,
                            positiveText: 'lbl_Yes'.translate,
                            negativeText: 'lbl_cancel'.translate,
                          );
                        }),
                  ],
                )
              ],
            ),
          ],
        ).expand(),
      ],
    );
  }
}
