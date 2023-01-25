import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/CustomerResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class AddCustomerScreen extends StatefulWidget {
  static String tag = '/EditCustomerScreen';
  CustomerResponse? customerData;
  final bool isAdd;
  final Function? onUpdate;

  AddCustomerScreen({this.customerData, this.isAdd = false, this.onUpdate});

  @override
  AddCustomerScreenState createState() => AddCustomerScreenState();
}

class AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  String? roleCont = '';

  List<String> roleList = [
    'Disable Vendor',
    'Store Vendor',
    'Vendor',
    'Shop Manager',
    'Customer',
    'Subscriber',
    'Contributor',
    'Author',
    'Editor',
    'Administrator',
    '--No role for this site--',
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> addCustomers() async {
    appStore.setLoading(true);
    var req = {
      'first_name': fNameCont.text.validate(),
      'last_name': lNameCont.text.validate(),
      'email': emailCont.text.validate(),
      'username': usernameCont.text.validate(),
      'password': passwordCont.text.validate(),
      'role': roleCont.validate(),
    };

    await addCustomer(req).then((value) {
      toast('Add Successfully');

      finish(context, value);
    }).catchError((e) {
      log(e.toString());
      toast(e.toString());
    }).whenComplete(() {
      LiveStream().emit(ADD_CUSTOMER, true);
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.isAdd ? 'lbl_Add_Customer'.translate : 'lbl_Update_Customer'.translate, showBack: true, color: primaryColor, textColor: white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.height,
                AppTextField(
                  controller: fNameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(context, 'hint_fName'.translate),
                ),
                16.height,
                AppTextField(
                  controller: lNameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(context, 'hint_lName'.translate),
                ),
                16.height,
                AppTextField(
                  controller: emailCont,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: inputDecoration(context, 'hint_enter_your_email_id'.translate),
                  errorInvalidEmail: 'invalid_email'.translate,
                ),
                16.height,
                AppTextField(
                  controller: usernameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(context, 'hintText_username'.translate),
                  errorThisFieldRequired: 'This field required',
                  enabled: widget.isAdd ? true : false,
                ),
                16.height,
                AppTextField(
                  controller: passwordCont,
                  textFieldType: TextFieldType.PASSWORD,
                  decoration: inputDecoration(context, 'hintText_password'.translate),
                  errorMinimumPasswordLength: 'password_validation'.translate,
                ).visible(widget.isAdd),
                24.height,
                AppButton(
                  text: 'lbl_Add'.translate,
                  textColor: white,
                  color: primaryColor,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);
                    addCustomers();
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
