import 'package:flutter/material.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../main.dart';

class AboutUsScreen extends StatefulWidget {
  static String tag = '/AboutUsScreen';

  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  PackageInfo? package;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    package = await PackageInfo.fromPlatform();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appBarWidget("lbl_about_us".translate, showBack: true, color: primaryColor, textColor: white),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                16.height,
                Container(width: 120, height: 120, padding: EdgeInsets.all(8), decoration: boxDecorationRoundedWithShadow(10), child: Image.asset(app_logo)),
                16.height,
                FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        return Column(
                          children: [
                            Text('${snap.data!.appName.validate()}', style: boldTextStyle(color: primaryColor, size: 18)),
                            Text('Version ${snap.data!.version.validate()}', style: secondaryTextStyle(size: 14))
                          ],
                        );
                      }
                      return SizedBox();
                    }),
                8.height
              ],
            ).center(),
          ),
        ),
      ),
    );
  }
}
