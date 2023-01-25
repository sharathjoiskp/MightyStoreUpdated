import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/screens/SplashScreen.dart';
import 'package:mightyAdmin/store/AppStore.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppLocalizations.dart';
import 'package:nb_utils/nb_utils.dart';

import 'utils/AppTheme.dart';

AppStore appStore = AppStore();
AppLocalizations? appLocalizations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  defaultRadius = 10.0;


  await Firebase.initializeApp();
  await initialize(aLocaleLanguageList: getLocalLanguage());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));
  appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: 'en'));

  defaultLoaderAccentColorGlobal = primaryColor;
  defaultLoaderBgColorGlobal=appStore.isDarkModeOn?Colors.black:Colors.white;
  Function? originalOnError = FlutterError.onError;

  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    originalOnError!(errorDetails);
  };

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp(
          //navigatorObservers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
          debugShowCheckedModeBanner: false,
          theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
          home: SplashScreen(),
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
          localeResolutionCallback: (locale, supportedLocales) => locale,
          locale: Locale(appStore.selectedLanguage!.languageCode.validate(value: defaultLanguage)),
          builder: scrollBehaviour(),
        );
      },
    );
  }
}
