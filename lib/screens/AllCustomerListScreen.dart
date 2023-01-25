import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyAdmin/component/CustomerItemWidget.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/CustomerResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/screens/AddCustomerScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AllCustomerListScreen extends StatefulWidget {
  static String tag = '/AllCustomerListScreen';

  @override
  AllCustomerListScreenState createState() => AllCustomerListScreenState();
}

class AllCustomerListScreenState extends State<AllCustomerListScreen> {
  bool mIsLastPage = false;
  int page = 1;
  List<CustomerResponse> customerList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    getAllCustomerList();
    LiveStream().on(UPDATE_CUSTOMER, (isUpdate) {
      if (isUpdate as bool) {
        setState(() {});
      }
    });

    scrollController.addListener(() {
      if ((scrollController.position.pixels - 100) == (scrollController.position.maxScrollExtent - 100)) {
        if (!mIsLastPage) {
          page++;
          appStore.setLoading(true);
          getAllCustomerList();
          setState(() {});
        }
      }
    });
  }

  Future<void> getAllCustomerList() async {
    appStore.setLoading(true);

    await getAllCustomer(page: page).then((res) async {
      if (page == 1) customerList.clear();

      customerList.addAll(res);
      mIsLastPage = res.length != perPage;
      setState(() {});
    }).catchError((e) {
      log(e.toString());
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    LiveStream().dispose(UPDATE_CUSTOMER);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("lbl_All_Customer".translate, showBack: true, color: primaryColor, textColor: white),
      body: Stack(
        children: [
          if (customerList.isNotEmpty)
            ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.all(8),
                itemCount: customerList.length,
                itemBuilder: (context, i) {
                  CustomerResponse data = customerList[i];
                  return CustomerItemWidget(
                    data: data,
                    onUpdate: () {
                      customerList.sort((a, b) => a.username!.compareTo(b.username!));
                      setState(() {});
                    },
                    onDelete: (id) {
                      toast('lbl_Delete'.translate);
                      customerList.removeWhere((element) => element.id == id);
                      setState(() {});
                    },
                  ).paddingAll(8);
                }, separatorBuilder: (BuildContext context, int index) { return Divider(); },),
          NoDataFound(
              title: 'no_customer_available'.translate,
              onPressed: () {
                finish(context);
              }).visible(!appStore.isLoading && customerList.isEmpty),
          Observer(builder: (_) => loading().visible(appStore.isLoading))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        backgroundColor: primaryColor,
        onPressed: () async {
          var res = await AddCustomerScreen(isAdd: true).launch(context);
          if (res != null) {
            if (res is bool) {
              if (res) {
                setState(() {});
              }
            } else if (res is CustomerResponse) {
              customerList.add(res);
              customerList.sort((a, b) => a.username!.compareTo(b.username!));

              setState(() {});
            }
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
