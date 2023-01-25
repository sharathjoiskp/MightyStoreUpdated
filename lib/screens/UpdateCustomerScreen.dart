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
class UpdateCustomerScreen extends StatefulWidget {
  static String tag = '/EditCustomerScreen';
  CustomerResponse? customerData;

  UpdateCustomerScreen({this.customerData});

  @override
  UpdateCustomerScreenState createState() => UpdateCustomerScreenState();
}

class UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
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
    fNameCont.text = widget.customerData!.firstName.validate();
    lNameCont.text = widget.customerData!.lastName.validate();
    emailCont.text = widget.customerData!.email.validate();
    usernameCont.text = widget.customerData!.username.validate();
    roleCont = widget.customerData!.role.validate();
  }

  Future<void> editCustomers() async {
    appStore.setLoading(true);

    var req = {
      'first_name': fNameCont.text.validate(),
      'last_name': lNameCont.text.validate(),
      'email': emailCont.text.validate(),
      'role': roleCont.validate(),
    };

    await editCustomer(customerId: widget.customerData!.id.validate(), request: req).then((res) {
      widget.customerData!.firstName = fNameCont.text.validate();
      widget.customerData!.lastName = lNameCont.text.validate();
      widget.customerData!.email = emailCont.text.validate();
      widget.customerData!.role = roleCont.validate();
      toast('lbl_update_successfully'.translate);

      finish(context, true);
    }).catchError((error) {
      log(error.toString());
      toast(error.toString().validate());
    }).whenComplete(() {
      LiveStream().emit(UPDATE_CUSTOMER, true);
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
      appBar: appBarWidget("lbl_Update_Customer".translate, showBack: true, color: primaryColor, textColor: white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
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
                  decoration: inputDecoration(context, 'Enter your Email'),
                  errorInvalidEmail: 'invalid_email'.translate,
                ),
                16.height,
                AppTextField(
                  controller: usernameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(context, 'hintText_username'.translate),
                  errorThisFieldRequired: 'This field required',
                  enabled: false,
                ),
               /* Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: iconColorSecondary, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: appStore.scaffoldBackground,
                    decoration: InputDecoration.collapsed(hintText: null),
                    hint: Text('select_status'.translate, style: primaryTextStyle()),
                    isExpanded: true,
                    items: roleList.map((location) {
                      return DropdownMenuItem(child: Text(location), value: location);
                    }).toList(),
                    onChanged: (String? value) {
                      roleCont = value;
                      setState(() {});
                    },
                  ),
                ),*/
                24.height,
                AppButton(
                  text: "lbl_Update_Customer".translate,
                  textColor: white,
                  color: primaryColor,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);
                    editCustomers();
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
