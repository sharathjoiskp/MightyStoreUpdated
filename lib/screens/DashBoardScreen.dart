import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/screens/OrderFragment.dart';
import 'package:mightyAdmin/screens/ProfileFragment.dart';
import 'package:mightyAdmin/screens/VendorDashboardScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppImages.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:mightyAdmin/utils/CustomLibraries/BubbleBotoomBar.dart';
import 'package:nb_utils/nb_utils.dart';

import 'HomeFragment.dart';
import 'ProductFragment.dart';

class DashBoardScreen extends StatefulWidget {
  static String tag = '/DashBoardScreen';

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  List<Widget> pages = [
    HomeFragment(),
    OrderFragment(),
    ProductFragment(),
    ProfileFragment(),
  ];

  List<Widget> vendorPages = [
    VendorDashboardScreen(),
    OrderFragment(),
    ProductFragment(),
    ProfileFragment(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //2.seconds.delay.then((value) => setStatusBarColor(transparentColor, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SafeArea(
        child: Scaffold(
          backgroundColor: appStore.scaffoldBackground,
          body: getStringAsync(USER_ROLE) == 'seller' ? vendorPages[currentIndex] : pages[currentIndex],
          bottomNavigationBar: CustomTheme(
            child: BubbleBottomBar(
              opacity: .2,
              backgroundColor: appStore.appBarColor,
              currentIndex: currentIndex,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              elevation: 8,
              onTap: changePage,
              hasNotch: false,
              hasInk: true,
              inkColor: primaryColor,
              items: <BubbleBottomBarItem>[
                tab(ic_home, "lbl_home".translate),
                tab(ic_category, "lbl_order".translate),
                tab(ic_total_order, "lbl_product".translate),
                tab(ic_user, "lbl_profile".translate),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
