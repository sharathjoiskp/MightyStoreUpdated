import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/AboutUsScreen.dart';
import 'package:mightyAdmin/screens/AllCustomerListScreen.dart';
import 'package:mightyAdmin/screens/CategoryScreen.dart';
import 'package:mightyAdmin/screens/LanguageSelectionScreen.dart';
import 'package:mightyAdmin/screens/ProductAttributeScreen.dart';
import 'package:mightyAdmin/screens/SignInScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:mightyAdmin/utils/AppLocalizations.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import 'ProductReviewScreen.dart';

class ProfileFragment extends StatefulWidget {
  static String tag = '/ProfileFragment';

  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 2));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) => Column(
            children: [
              appStore.isLoggedIn
                  ? Stack(
                      children: [
                        Container(
                          height: context.height() * 0.1,
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), bottomLeft: Radius.circular(60)),
                            backgroundColor: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
                          child: Row(
                            children: [
                              cachedImage(getStringAsync(AVATAR), height: 60, width: 60, fit: BoxFit.cover).cornerRadiusWithClipRRect(30),
                              10.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${getStringAsync(FIRST_NAME)} ${getStringAsync(LAST_NAME)}', style: boldTextStyle(size: 18, color: white)),
                                  Text(getStringAsync(USER_EMAIL), style: secondaryTextStyle(color: white)),
                                ],
                              )
                            ],
                          ),
                        ).onTap(() {
                          //
                        }),
                      ],
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor)),

                      child: Text('lbl_login'.translate, style: boldTextStyle()),
                    ).onTap(() async {
                      await SignInScreen().launch(context, isNewTask: true);
                      setState(() {});
                    }).paddingAll(16),
              if (!isVendor)
                SettingItemWidget(
                  title: "lbl_All_Customer".translate,
                  titleTextStyle: primaryTextStyle(size: 18),
                  leading: Image.asset(ic_user, height: 20, width: 20, color: appStore.iconSecondaryColor),
                  onTap: () {
                    AllCustomerListScreen().launch(context);
                  },
                ),
              //Divider(height: 0),
              SettingItemWidget(
                title: "lbl_Product_Attribute".translate,
                titleTextStyle: primaryTextStyle(size: 18),
                leading: Image.asset(ic_category, height: 20, width: 20, color: appStore.iconSecondaryColor),
                onTap: () {
                  ProductAttributeScreen().launch(context);
                },
              ),
              //Divider(height: 0),
              SettingItemWidget(
                title: "lbl_Category".translate,
                titleTextStyle: primaryTextStyle(size: 18),
                leading: Image.asset(ic_category, height: 20, width: 20, color: appStore.iconSecondaryColor),
                onTap: () {
                  CategoryScreen().launch(context);
                },
              ),
              //Divider(height: 0),
              SettingItemWidget(
                title: "lbl_reviews".translate,
                titleTextStyle: primaryTextStyle(size: 18),
                leading: Icon(AntDesign.staro, color: appStore.iconSecondaryColor),
                onTap: () {
                  ProductReviewScreen().launch(context);
                },
              ).visible(!isVendor),
              //Divider(height: 0).visible(!isVendor),
              SettingItemWidget(
                padding: EdgeInsets.symmetric(horizontal: 16),
                title: "lbl_mode".translate,
                titleTextStyle: primaryTextStyle(size: 18),
                onTap: () async {
                  appStore.toggleDarkMode(value: !appStore.isDarkModeOn);
                },
                leading: Icon(MaterialCommunityIcons.theme_light_dark, color: appStore.iconSecondaryColor),
                trailing: Switch(
                  value: appStore.isDarkModeOn,
                  onChanged: (s) async {
                    appStore.toggleDarkMode(value: s);
                  },
                ),
              ),
              //Divider(height: 0),
              SettingItemWidget(
                titleTextStyle: primaryTextStyle(size: 18),
                leading: Icon(Icons.language, color: appStore.iconSecondaryColor),
                title: "language".translate,
                trailing: Row(
                  children: [
                    Text(appStore.selectedLanguage!.name.validate(), style: boldTextStyle()),
                    16.width,
                    Image.asset(appStore.selectedLanguage!.flag.validate(), scale: 4, height: 30),
                  ],
                ),
                onTap: () {
                  appLocalizations = AppLocalizations.of(context);
                  LanguageSelectionScreen().launch(context);
                },
              ),
              //Divider(height: 0),
              SettingItemWidget(
                title: "lbl_about_us".translate,
                titleTextStyle: primaryTextStyle(size: 18),
                leading: Icon(MaterialCommunityIcons.information_outline, color: appStore.iconSecondaryColor),
                onTap: () {
                  AboutUsScreen().launch(context);
                },
              ),
              //Divider(height: 0),
              SettingItemWidget(
                title: "lbl_logout".translate,
                titleTextStyle: primaryTextStyle(size: 18),
                leading: Image.asset(ic_login, height: 20, width: 20, color: appStore.iconSecondaryColor),
                onTap: () async {
                  logout(context);
                },
              ).visible(appStore.isLoggedIn)
            ],
          ),
        ),
      ),
    );
  }
}
