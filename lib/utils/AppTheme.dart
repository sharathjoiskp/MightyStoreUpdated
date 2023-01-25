import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    errorColor: Colors.red,
    hoverColor: Colors.grey,
    dividerColor: viewLineColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: app_Background,
      iconTheme: IconThemeData(color: textPrimaryColor),
      brightness: Brightness.light,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      primaryVariant: primaryColor,
    ),
    cardTheme: CardTheme(color: Colors.white),
    iconTheme: IconThemeData(color: textPrimaryColor),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: whiteColor),
    textTheme: TextTheme(
      button: TextStyle(color: primaryColor),
      headline6: TextStyle(color: textPrimaryColor),
      subtitle2: TextStyle(color: textSecondaryColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    highlightColor: appBackgroundColorDark,
    errorColor: Color(0xFFCF6676),
    appBarTheme: AppBarTheme(
      color: appBackgroundColorDark,
      iconTheme: IconThemeData(color: whiteColor),
      brightness: Brightness.dark,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: appBackgroundColorDark,
    accentColor: whiteColor,
    dividerColor: Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: color_primary_black,
    unselectedWidgetColor: appColorPrimaryDarkLight,
    hoverColor: Colors.black,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    primaryTextTheme: TextTheme(
      headline6: primaryTextStyle(color: Colors.white),
      overline: primaryTextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: appBackgroundColorDark,
      onPrimary: cardBackgroundBlackDark,
      primaryVariant: color_primary_black,
    ),
    cardTheme: CardTheme(color: cardBackgroundBlackDark),
    iconTheme: IconThemeData(color: whiteColor),
    textTheme: TextTheme(
      button: TextStyle(color: color_primary_black),
      headline6: TextStyle(color: whiteColor),
      subtitle2: TextStyle(color: Colors.white54),
    ),
  );
}
