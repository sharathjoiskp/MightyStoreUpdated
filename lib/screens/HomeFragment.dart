import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mightyAdmin/component/ExpandChartToLandScapeModeComponent.dart';
import 'package:mightyAdmin/component/HorizontalBarChart.dart';
import 'package:mightyAdmin/component/OrderCardWidget.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/DashboardResponse.dart';
import 'package:mightyAdmin/models/OrderResponse.dart';
import 'package:mightyAdmin/models/SummaryResponse.dart';
import 'package:mightyAdmin/network/rest_apis.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:mightyAdmin/utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeFragment extends StatefulWidget {
  static String tag = '/HomeFragment';

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  SummaryResponse? summaryResponse;

  DateTimeRange? picked = DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTime firstDayCurrentMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

  List<SaleReport> saleReportList = [];
  List<NewComment> newCommentList = [];
  List<SaleTotalData> topSaleTotalList = [];
  List<OrderTotal> orderSummaryTotalList = [];
  List<ProductsTotal> productSummaryTotalList = [];
  List<OrderTotal> customerTotalList = [];
  List<OrderResponse> newOrderList = [];
  List<SaleTotalData> orderTotalList = [];

  String date = 'Select date';
  String dateMin = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateMax = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String topDateMin = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String topDateMax = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String errorMsg = '';

  List<String> periodType = ['week', 'month', 'last_month', 'year'];

  String? selectPeriod = "week";

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    dateMin = DateFormat('yyyy-MM-dd').format(firstDayCurrentMonth);
    date = "[ $dateMin to $dateMax ]";
    dashboardData(dateMin: dateMin, dateMax: dateMax);
  }

  Future<void> dashboardData({String? dateMin, String? dateMax}) async {
    appStore.setLoading(true);

    await getDashboard(dateMin: dateMin, dateMax: dateMax, period: selectPeriod).then((value) {
      Iterable newOrder = value['new_order'];
      newOrderList.addAll(newOrder.map((e) => OrderResponse.fromJson(e)).toList());

      Iterable customerTotal = value['customer_total'];
      customerTotalList.addAll(customerTotal.map((e) => OrderTotal.fromJson(e)).toList());

      Iterable saleReport = value['sale_report'];
      saleReportList.addAll(saleReport.map((e) => SaleReport.fromJson(e)).toList());

      Iterable comment = value['new_comment'];
      newCommentList.addAll(comment.map((e) => NewComment.fromJson(e)).toList());

      Iterable order = value['order_total'];
      orderSummaryTotalList.addAll(order.map((e) => OrderTotal.fromJson(e)).toList());

      Iterable product = value['products_total'];
      productSummaryTotalList.addAll(product.map((e) => ProductsTotal.fromJson(e)).toList());

      (value['top_sale_report'] as Iterable).forEach((element) {
        List<SaleTotalData> value = [];

        (element['totals'] as Map).entries.forEach((element) {
          value.add(SaleTotalData.fromJson(element.value)..key = element.key);
        });

        topSaleTotalList.addAll(value);
        setState(() {});
      });

      log('Top Sell Report:- ${topSaleTotalList.length}');

      (value['sale_report'] as Iterable).forEach((element) {
        List<SaleTotalData> value = [];

        (element['totals'] as Map).entries.forEach((element) {
          value.add(SaleTotalData.fromJson(element.value)..key = element.key);
        });

        orderTotalList.addAll(value);
        setState(() {});
      });
    }).catchError((e) {
      errorMsg = e.toString();
      log(e);
      setState(() {});
    });

    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    void clearListApiCall() {
      saleReportList.clear();
      newCommentList.clear();
      topSaleTotalList.clear();
      orderSummaryTotalList.clear();
      productSummaryTotalList.clear();
      customerTotalList.clear();
      newOrderList.clear();
      orderTotalList.clear();
      dashboardData(dateMin: dateMin, dateMax: dateMax);
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: context.height(),
            width: context.width(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: context.height() * 0.1,
                        decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), bottomLeft: Radius.circular(60)), backgroundColor: primaryColor),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.height,
                          Text("${DateFormat.yMMMMd().format(DateTime.now())}", style: secondaryTextStyle(size: 16, color: white)).paddingLeft(20),
                          Text('${'lbl_Hello'.translate} ${getStringAsync(FIRST_NAME)} ${getStringAsync(LAST_NAME)}', style: boldTextStyle(size: 18, color: white)).paddingLeft(20),
                        ],
                      ),
                    ],
                  ),
                  16.height,
                  if (saleReportList.validate().isNotEmpty)
                    Container(
                      decoration: boxDecoration(context, showShadow: true, radius: defaultRadius),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 16, bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('lbl_total_sale'.translate, style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis).expand(),
                              8.width,
                              Row(
                                children: [
                                  Text('$date', style: primaryTextStyle()),
                                  4.width,
                                  Icon(Icons.date_range, color: appStore.iconColor, size: 20),
                                ],
                              ).onTap(() async {
                                picked = await showDateRangePicker(
                                  firstDate: DateTime(1900),
                                  initialDateRange: picked,
                                  context: context,
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: appStore.isDarkModeOn
                                          ? ThemeData.dark().copyWith(
                                              colorScheme: ColorScheme.dark(primary: primaryColor, onPrimary: Colors.white, surface: primaryColor, onSurface: Colors.white),
                                              dialogBackgroundColor: Theme.of(context).cardColor,
                                            )
                                          : ThemeData.light().copyWith(primaryColor: primaryColor),
                                      child: child.paddingAll(8),
                                    );
                                  },
                                );
                                if (picked != null) {
                                  date = "[ ${DateFormat('dd-MM-yyyy').format(picked!.start)} to ${DateFormat('dd-MM-yyyy').format(picked!.end)} ]";
                                  dateMin = DateFormat('yyyy-MM-dd').format(picked!.start);
                                  dateMax = DateFormat('yyyy-MM-dd').format(picked!.end);
                                  setState(() {});
                                  clearListApiCall();
                                }
                              }),
                              4.width,
                            ],
                          ),
                          Divider(),
                          10.height,
                          Row(
                            children: [
                              Expanded(child: cardWidget(context, orderName: "lbl_total_sale".translate, total: saleReportList.first.totalSales.validate().toInt()), flex: 1),
                              10.width,
                              Expanded(child: cardWidget(context, orderName: "lbl_net_sale".translate, total: saleReportList.first.netSales.validate().toInt()), flex: 1),
                              10.width,
                              Expanded(child: cardWidget(context, orderName: "lbl_average_sale".translate, total: saleReportList.first.averageSales.validate().toInt()), flex: 1),
                            ],
                          ),
                          10.height,
                          Row(
                            children: [
                              Expanded(child: cardWidget(context, orderName: "lbl_total_orders".translate, total: saleReportList.first.totalOrders.toString().validate().toInt()), flex: 1),
                              10.width,
                              Expanded(child: cardWidget(context, orderName: "lbl_total_items".translate, total: saleReportList.first.totalItems.toString().validate().toInt()), flex: 1),
                              10.width,
                              Expanded(child: cardWidget(context, orderName: "lbl_total_shipping".translate, total: saleReportList.first.totalShipping.toString().validate().toInt()), flex: 1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (orderTotalList.isNotEmpty)
                    Container(
                      decoration: boxDecoration(context, showShadow: true, radius: defaultRadius),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 10, left: 8, right: 8),
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('lbl_sale_report'.translate, style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis).expand(),
                              IconButton(
                                icon: Icon(
                                  Icons.crop_rotate_rounded,
                                ),
                                onPressed: () {
                                  ExpandChartToLandScapeModeComponent(orderTotalList).launch(context);
                                },
                              )
                            ],
                          ),
                          8.height,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: HorizontalBarChart(orderTotalList).withSize(
                              width: context.width(),
                              height: 350,
                            ),
                          ),
                          16.height,
                        ],
                      ),
                    ),
                  if (topSaleTotalList.isNotEmpty)
                    Container(
                      decoration: boxDecoration(context, showShadow: true, radius: defaultRadius),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 10, left: 8, right: 8),
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('lbl_top_sellers_report'.translate, style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
                              Container(
                                width: 110,
                                decoration: BoxDecoration(border: Border.all(color: viewLineColor), borderRadius: radius(8)),
                                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                                child: DropdownButton<String>(
                                  value: selectPeriod,
                                  dropdownColor: appStore.scaffoldBackground,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  items: periodType.map((e) => DropdownMenuItem(value: e, child: Text(e, style: primaryTextStyle()))).toList(),
                                  onChanged: (String? value) {
                                    selectPeriod = value;
                                    setState(() {});
                                    clearListApiCall();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.crop_rotate_rounded),
                              onPressed: () {
                                ExpandChartToLandScapeModeComponent(topSaleTotalList).launch(context);
                              },
                            ),
                          ),
                          8.height,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: HorizontalBarChart(topSaleTotalList, chartType: ChartType.CHART3).withSize(width: context.width(), height: 350),
                          ),
                          8.height,
                        ],
                      ),
                    ),
                  if (orderSummaryTotalList.isNotEmpty)
                    Container(
                      decoration: boxDecoration(context, showShadow: true, radius: defaultRadius),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 16, bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('lbl_order_total'.translate, style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Divider(),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: orderSummaryTotalList.map(
                              (e) {
                                return cardWidget(context, orderName: e.name, total: e.total, width: context.width() * 0.31 - 8);
                              },
                            ).toList(),
                          )
                        ],
                      ),
                    ),
                  if (productSummaryTotalList.validate().isNotEmpty)
                    Container(
                      decoration: boxDecoration(context, showShadow: true, radius: defaultRadius),
                      padding: EdgeInsets.all(8),
                      width: context.width(),
                      margin: EdgeInsets.only(top: 16, bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('lbl_product_total'.translate, style: boldTextStyle(size: 18)),
                          6.height,
                          Wrap(
                            spacing: 16.0,
                            runSpacing: 8.0,
                            children: productSummaryTotalList.map(
                              (e) {
                                return cardWidget(context, width: context.width() / 2 - 26, orderName: e.name, total: e.total);
                              },
                            ).toList(),
                          )
                        ],
                      ),
                    ),
                  if (customerTotalList.validate().isNotEmpty)
                    Container(
                      decoration: boxDecoration(context, showShadow: true, radius: defaultRadius),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 16, bottom: 10, left: 8, right: 8),
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('lbl_customer_total'.translate, style: boldTextStyle(size: 18)),
                          6.height,
                          Wrap(
                            spacing: 16.0,
                            runSpacing: 8.0,
                            children: customerTotalList.map(
                              (e) {
                                return cardWidget(context, orderName: e.name, total: e.total, width: context.width() / 2 - 26);
                              },
                            ).toList(),
                          )
                        ],
                      ),
                    ),
                  if (newOrderList.isNotEmpty)
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('lbl_new_order'.translate, style: boldTextStyle(size: 18)).paddingSymmetric(horizontal: 16, vertical: 16),
                          ListView.separated(
                            separatorBuilder: (context, i) => Divider(height: 0),
                            itemCount: newOrderList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              OrderResponse data = newOrderList[i];
                              return OrderCardWidget(
                                orderResponse: data,
                                onUpdate: () {
                                  setState(() {});
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  if (newCommentList.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('lbl_new_comment'.translate, style: boldTextStyle(size: 18)),
                          16.height,
                          ListView.separated(
                            separatorBuilder: (context, i) => Divider(height: 16),
                            itemCount: newCommentList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              NewComment data = newCommentList[i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      cachedImage(getStringAsync(AVATAR), height: 40, width: 40, fit: BoxFit.cover).cornerRadiusWithClipRRect(80),
                                      8.width,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          4.height,
                                          Text(parseHtmlString('${data.commentAuthor.capitalizeFirstLetter()}'), style: secondaryTextStyle()),
                                          6.height,
                                          Text(parseHtmlString('${data.commentContent}'), style: boldTextStyle()),
                                          2.height,
                                          Text(DateFormat.yMMMEd().format(DateTime.parse(data.commentDate!)), style: secondaryTextStyle(size: 14)),
                                          4.height,
                                        ],
                                      ).expand(),
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Observer(builder: (_) => loading().center().visible(appStore.isLoading)),
          Text(errorMsg).center().visible(errorMsg.isNotEmpty)
        ],
      ),
    );
  }
}
