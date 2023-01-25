import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppLocalizations.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: appBarWidget(
        "",
        color: primaryColor,
        titleWidget: Text('lbl_Language_support'.translate, style: boldTextStyle(color: white)),
        backWidget: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(Icons.arrow_back, color: white),
        ),
      ),
      body: LanguageListWidget(
        onLanguageChange: (LanguageDataModel s) async {
          appStore.setLanguage(s.languageCode);
          finish(context);
        },
      ),
    );
  }
}
