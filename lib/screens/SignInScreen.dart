import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/DashBoardScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import 'SignUpScreen.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  Future<void> signInApi(req) async {
    appStore.setLoading(true);

    await login(req).then((res) async {
      if (!mounted) return;

      appStore.setLoading(false);

      if (appStore.isLoggedIn) DashBoardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }).catchError((error) {
      log("Error" + error.toString());
      appStore.setLoading(false);

      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(primaryColor);
    return Scaffold(
      backgroundColor: colorAccent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: context.height() * 0.3,
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(60), bottomLeft: Radius.circular(0)),
                    backgroundColor: primaryColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("lbl_welcome".translate, style: boldTextStyle(color: white_color, size: 32, letterSpacing: 1)).expand(),
                    Image.asset(ic_login1, height: 160, width: 160, fit: BoxFit.contain).paddingOnly(top: 20),
                  ],
                ).paddingOnly(top: 60, left: 16, right: 16),
                Container(
                  decoration: BoxDecoration(color: appStore.scaffoldBackground, borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 50),
                  margin: EdgeInsets.only(top: 200, bottom: 20, right: 16, left: 16),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(alignment: Alignment.topLeft, child: Text("lbl_login".translate, style: boldTextStyle(size: 25))).paddingOnly(right: 16, left: 16),
                          40.height,
                          AppTextField(
                            controller: usernameCont,
                            textFieldType: TextFieldType.NAME,
                            focus: usernameFocus,
                            nextFocus: passwordFocus,
                            textStyle: secondaryTextStyle(color: white),
                            decoration: inputDecoration(context, "hint_Username".translate),
                          ).paddingOnly(right: 16, left: 16),
                          20.height,
                          AppTextField(
                            controller: passwordCont,
                            textFieldType: TextFieldType.PASSWORD,
                            focus: passwordFocus,
                            textStyle: secondaryTextStyle(color: white),
                            decoration: inputDecoration(context, "hint_password".translate),
                          ).paddingOnly(right: 16, left: 16),
                          8.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomTheme(
                                    child: Checkbox(
                                      focusColor: primaryColor,
                                      activeColor: primaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      value: getBoolAsync(REMEMBER_PASSWORD, defaultValue: true),
                                      onChanged: (bool? value) async {
                                        await setValue(REMEMBER_PASSWORD, value);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Text("lbl_remember_me".translate, style: secondaryTextStyle(color: Colors.white)).onTap(() async {
                                    await setValue(REMEMBER_PASSWORD, !getBoolAsync(REMEMBER_PASSWORD));
                                    setState(() {});
                                  }),
                                ],
                              ),
                              Text("lbl_forgot_password".translate, style: secondaryTextStyle(color: Colors.white)).onTap(() {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => CustomDialog(),
                                );
                              }),
                            ],
                          ).paddingOnly(right: 16, left: 6),
                          30.height,
                          AppButton(
                            width: context.width(),
                            color: primaryColor,
                            text: "lbl_sign_in".translate,
                            textStyle: primaryTextStyle(letterSpacing: 1, color: Colors.white),
                            onTap: () {
                              hideKeyboard(context);
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (!mounted) return;
                                if (usernameCont.text.isEmpty)
                                  toast("hint_Username".translate + " " + "error_field_required".translate);
                                else if (passwordCont.text.isEmpty)
                                  toast("hint_password".translate + " " + "error_field_required".translate);
                                else {
                                  appStore.setLoading(false);
                                  var request = {"username": "${usernameCont.text}", "password": "${passwordCont.text}"};
                                  signInApi(request);
                                }
                                if (!accessAllowed) {
                                  toast("Sorry");
                                  return;
                                }
                              }

                              setState(() {});
                            },
                          ).paddingOnly(right: 16, left: 16),
                          30.height,
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("lbl_don_t_have_account".translate, style: primaryTextStyle(size: 16, color: white)),
                              GestureDetector(
                                  child: Text("lbl_sign_up".translate, style: TextStyle(fontSize: 16, color: primaryColor)),
                                  onTap: () {
                                    SignUpScreen().launch(context);
                                  }).paddingOnly(left: 6),
                            ],
                          ).paddingOnly(right: 16, left: 16),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          loading().center().visible(appStore.isLoading)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  var email = TextEditingController();
  var emailFocus = FocusNode();
  var formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: boxDecoration(context, radius: 10.0),
          child: Form(
            key: formKeys,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text("lbl_forgot_password".translate, style: boldTextStyle(size: 24)).paddingOnly(left: 16, right: 16, top: 16),
                  4.height,
                  Divider(),
                  20.height,
                  Column(
                    children: [
                      CommonTextFormField(
                        labelText: "hint_enter_your_email_id".translate,
                        isPassword: false,
                        mController: email,
                        focusNode: emailFocus,
                        validator: (String? s) {
                          if (s!.trim().isEmpty) return "error_email_required".translate;
                          return null;
                        },
                      ),
                    ],
                  ).paddingOnly(left: 16, right: 16, bottom: spacing_standard.toDouble()),
                  AppButton(
                    width: context.width(),
                    color: primaryColor,
                    text: "lbl_submit".translate,
                    textStyle: primaryTextStyle(letterSpacing: 1, color: Colors.white),
                    onTap: () {
                      if (formKeys.currentState!.validate()) {
                        formKeys.currentState!.save();
                        if (!accessAllowed) {
                          toast("Sorry");
                          return;
                        }
                        if (email.text.isEmpty) toast("hint_Email".translate + "error_field_required".translate);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ).paddingAll(16)
                ],
              ),
            ),
          )),
    );
  }
}
