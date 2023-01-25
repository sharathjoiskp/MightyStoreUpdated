import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  static String tag = '/SignUpScreen';

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode cPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(Colors.transparent);
  }

  signUpApi() async {
    hideKeyboard(context);
    Map request = {
      'email': emailCont.text,
      'first_name': fNameCont.text,
      'last_name': lNameCont.text,
      'username': usernameCont.text,
      'password': passwordCont.text,
    };

    appStore.setLoading(true);

    await createCustomer(request).then((res) {
      if (!mounted) return;
      toast('Register Successfully');

      appStore.setLoading(false);

      finish(context);
    }).catchError((error) {
      appStore.setLoading(false);

      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent);
    return Scaffold(
      backgroundColor: colorAccent,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(60), bottomLeft: Radius.circular(0)),
                backgroundColor: primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_welcome".translate,
                  style: boldTextStyle(color: white_color, size: 36, letterSpacing: 1),
                ).expand(),
                Image.asset(ic_login1, height: 160, width: 160, fit: BoxFit.contain).paddingOnly(top: 20),
              ],
            ).paddingOnly(top: 60, left: 16, right: 16),
            Container(
              decoration: BoxDecoration(
                color: appStore.scaffoldBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
              margin: EdgeInsets.only(top: 225, right: 16, left: 16, bottom: 32),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("lbl_sign_up".translate, style: boldTextStyle(size: 25)),
                    ),
                    35.height,
                    Row(
                      children: [
                        AppTextField(
                          controller: fNameCont,
                          textFieldType: TextFieldType.NAME,
                          decoration: inputDecoration(context, "hint_first_name".translate),
                          nextFocus: lNameFocus,
                          autoFocus: true,
                        ).expand(),
                        8.width,
                        AppTextField(
                          controller: lNameCont,
                          textFieldType: TextFieldType.NAME,
                          focus: lNameFocus,
                          nextFocus: emailFocus,
                          decoration: inputDecoration(context, "hint_last_name".translate),
                        ).expand(),
                      ],
                    ),
                    spacing_standard_new.height,
                    AppTextField(
                      controller: emailCont,
                      textFieldType: TextFieldType.EMAIL,
                      focus: emailFocus,
                      nextFocus: usernameFocus,
                      decoration: inputDecoration(context, "hint_Email".translate),
                    ),
                    spacing_standard_new.height,
                    AppTextField(
                      controller: usernameCont,
                      textFieldType: TextFieldType.NAME,
                      focus: usernameFocus,
                      nextFocus: passwordFocus,
                      decoration: inputDecoration(context, "hint_Username".translate),
                    ),
                    spacing_standard_new.height,
                    AppTextField(
                      controller: passwordCont,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: passwordFocus,
                      nextFocus: cPasswordFocus,
                      decoration: inputDecoration(context, "hint_password".translate),
                    ),
                    16.height,
                    AppTextField(
                      controller: confirmPasswordCont,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: cPasswordFocus,
                      decoration: inputDecoration(context, "hint_confirm_password".translate),
                      validator: (String? s) {
                        if (s!.trim().isEmpty) return "error_confirm_password_required".translate;
                        if (passwordCont.text != confirmPasswordCont.text) return "error_password_not_match".translate;
                        return null;
                      },
                    ),
                    50.height,
                    AppButton(
                      width: context.width(),
                      color: primaryColor,
                      text: "lbl_sign_up".translate,
                      textStyle: primaryTextStyle(letterSpacing: 1, color: Colors.white),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          if (!accessAllowed) {
                            toast("Sorry");
                            return;
                          }
                          signUpApi();
                        }
                      },
                    ),
                    35.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("lbl_already_have_account".translate, style: primaryTextStyle(size: 18, color: Theme.of(context).textTheme.headline6!.color)),
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          child: GestureDetector(
                              child: Text("lbl_sign_in".translate, style: TextStyle(fontSize: 18, color: primaryColor)),
                              onTap: () {
                                finish(context);
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
