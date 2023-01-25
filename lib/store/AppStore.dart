import 'package:flutter/material.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isDarkModeOn = false;

  @observable
  Color? scaffoldBackground;

  @observable
  Color? backgroundColor;

  @observable
  Color? backgroundSecondaryColor;

  @observable
  Color? textPrimaryColor;

  @observable
  Color? appColorPrimaryLightColor;

  @observable
  Color? textSecondaryColor;

  @observable
  Color? appBarColor;

  @observable
  Color? iconColor;

  @observable
  Color? iconSecondaryColor;

  @observable
  LanguageDataModel? selectedLanguage;

  @observable
  var selectedDrawerItem = 0;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  void setLoggedIn(bool val) {
    isLoggedIn = val;
    setBoolAsync(IS_LOGGED_IN, val);
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkModeOn = aIsDarkMode;

    if (isDarkModeOn) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = textSecondaryColor!;
      shadowColorGlobal = Colors.white12;
      setStatusBarColor(primaryColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light);

    } else {
      textPrimaryColorGlobal = textPrimaryColor!;
      textSecondaryColorGlobal = textSecondaryColor!;
      shadowColorGlobal = Colors.black12;
      setStatusBarColor(primaryColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light);
    }
  }

  @action
  Future<void> toggleDarkMode({bool? value}) async {
    isDarkModeOn = value ?? !isDarkModeOn;

    if (isDarkModeOn) {

      appBarColor = cardBackgroundBlackDark;
      backgroundColor = Colors.white;
      backgroundSecondaryColor = Colors.white;
      appColorPrimaryLightColor = cardBackgroundBlackDark;

      iconColor = iconColorPrimary;
      iconSecondaryColor = iconColorSecondary;

      textPrimaryColor = whiteColor;
      textSecondaryColor = Colors.white54;

      textPrimaryColorGlobal = whiteColor;
      textSecondaryColorGlobal = Colors.white54;
      shadowColorGlobal = appShadowColorDark;
      appBarBackgroundColorGlobal = cardBackgroundBlackDark;
    } else {

      appBarColor = white_color;
      backgroundColor = Colors.black;
      backgroundSecondaryColor = appSecondaryBackgroundColor;
      appColorPrimaryLightColor = appColorPrimaryLight;

      iconColor = iconColorPrimaryDark;
      iconSecondaryColor = iconColorSecondaryDark;

      textPrimaryColor = textColorPrimary;
      textSecondaryColor = textColorSecondary;

      textPrimaryColorGlobal = textColorPrimary;
      textSecondaryColorGlobal = textColorSecondary;
      shadowColorGlobal = shadow_color;
      appBarBackgroundColorGlobal = Colors.white;
    }

    await setBool(isDarkModeOnPref, isDarkModeOn);
  }

  @action
  Future<void>? setLanguage(String? aCode) {
    log("Selected language $aCode");
    selectedLanguage = getSelectedLanguageModel(defaultLanguage: defaultLanguage);
    return null;
  }

  @action
  void setDrawerItemIndex(int aIndex) => selectedDrawerItem = aIndex;
}
