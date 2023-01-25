import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:mightyAdmin/component/OrderCardWidget.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'AppConstants.dart';

extension SExt on String {
  String get translate => appLocalizations!.translate(this);
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

String convertDate(date) {
  try {
    return date != null ? DateFormat(orderDateFormat).format(DateTime.parse(date)) : '';
  } catch (e) {
    print(e);
    return '';
  }
}

bool get isVendor => getStringAsync(USER_ROLE) == "seller";

Widget mSale(ProductDetailResponse1 product) {
  return Positioned(
    left: 0,
    top: 0,
    child: Container(
      decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.red, borderRadius: radiusOnly(topLeft: 8)),
      child: Text("Sale", style: secondaryTextStyle(color: white, size: 12)),
      padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
    ),
  ).visible(product.onSale == true);
}

List<LanguageDataModel> getLocalLanguage() {
  List<LanguageDataModel> data = [];
  data.add(LanguageDataModel(id: 0, name: 'English', languageCode: 'en', flag: 'images/flags/ic_us.png'));
  data.add(LanguageDataModel(id: 1, name: 'Afrikaans', languageCode: 'af', flag: 'images/flags/ic_afrikaans.png'));
  data.add(LanguageDataModel(id: 2, name: 'Arabic', languageCode: 'ar', flag: 'images/flags/ic_ar.png'));
  data.add(LanguageDataModel(id: 3, name: 'Bengali', languageCode: 'bn', flag: 'images/flags/ic_india.png'));
  data.add(LanguageDataModel(id: 4, name: 'German', languageCode: 'de', flag: 'images/flags/ic_germany.png'));
  data.add(LanguageDataModel(id: 5, name: 'Spanish', languageCode: 'es', flag: 'images/flags/ic_spanish.png'));
  data.add(LanguageDataModel(id: 6, name: 'French', languageCode: 'fr', flag: 'images/flags/ic_french.png'));
  data.add(LanguageDataModel(id: 7, name: 'Hebrew', languageCode: 'he', flag: 'images/flags/ic_herbew.png'));
  data.add(LanguageDataModel(id: 8, name: 'Hindi', languageCode: 'hi', flag: 'images/flags/ic_india.png'));
  data.add(LanguageDataModel(id: 9, name: 'Italian', languageCode: 'it', flag: 'images/flags/ic_italy.png'));
  data.add(LanguageDataModel(id: 10, name: 'Japanese', languageCode: 'ja', flag: 'images/flags/ic_japanese.png'));
  data.add(LanguageDataModel(id: 11, name: 'Korean', languageCode: 'ko', flag: 'images/flags/ic_korean.png'));
  data.add(LanguageDataModel(id: 12, name: 'Marathi', languageCode: 'mr', flag: 'images/flags/ic_india.png'));
  data.add(LanguageDataModel(id: 13, name: 'Nepali', languageCode: 'ne', flag: 'images/flags/ic_india.png'));
  data.add(LanguageDataModel(id: 14, name: 'dutch', languageCode: 'nl', flag: 'images/flags/ic_germany.png'));
  data.add(LanguageDataModel(id: 15, name: 'portuguese', languageCode: 'pt', flag: 'images/flags/ic_portuguese.png'));
  data.add(LanguageDataModel(id: 16, name: 'Romanian', languageCode: 'ro', flag: 'images/flags/ic_russia.png'));
  data.add(LanguageDataModel(id: 17, name: 'Tamil', languageCode: 'ta', flag: 'images/flags/ic_india.png'));
  data.add(LanguageDataModel(id: 18, name: 'Telugu', languageCode: 'te', flag: 'images/flags/ic_india.png'));
  data.add(LanguageDataModel(id: 19, name: 'Thai', languageCode: 'th', flag: 'images/flags/ic_thai.png'));
  data.add(LanguageDataModel(id: 20, name: 'Turkish', languageCode: 'tr', flag: 'images/flags/ic_turkey.png'));
  data.add(LanguageDataModel(id: 21, name: 'Vietnamese', languageCode: 'vi', flag: 'images/flags/ic_vietnamese.png'));
  data.add(LanguageDataModel(id: 22, name: 'Chinese', languageCode: 'zh', flag: 'images/flags/ic_chinese.png'));
  return data;
}

class QueryString {
  static Map parse(String query) {
    var search = new RegExp('([^&=]+)=?([^&]*)');
    var result = new Map();

    // Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);

    // A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    // Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1)!)] = decode(match.group(2)!);
    }

    return result;
  }
}

Widget cardWidget(BuildContext context, {String? orderName, int? total, double? width}) {
  return Container(
    decoration: boxDecorationDefault(color: statusColor(orderName!.toLowerCase()).withOpacity(0.3), boxShadow: <BoxShadow>[]),
    padding: EdgeInsets.all(10),
    width: width ?? context.width() / 3 - 22,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(orderName.validate(), style: boldTextStyle(size: 14, color: statusColor(orderName.toLowerCase())), maxLines: 2, overflow: TextOverflow.ellipsis),
        10.height,
        Text("$total", style: primaryTextStyle(size: 24, color: statusColor(orderName.toLowerCase()))),
      ],
    ),
  );
}

Widget cardWidget1(BuildContext context, {String? orderName, int? total, double? width}) {
  return Container(
    decoration: boxDecorationDefault(color: statusColor(orderName!.toLowerCase()).withOpacity(0.3), boxShadow: <BoxShadow>[]),
    padding: EdgeInsets.all(10),
    width: width ?? context.width() / 3 - 22,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(orderName.validate(), style: boldTextStyle(size: 14, color: statusColor(orderName.toLowerCase())), maxLines: 2, overflow: TextOverflow.ellipsis),
        10.height,
        Text("$total", style: primaryTextStyle(size: 24, color: statusColor(orderName.toLowerCase()))),
      ],
    ),
  );
}

Widget commonEditButtonComponent({IconData? icon, Color? color, Function? onCall}) {
  return Container(
    margin: EdgeInsets.only(left: 12),
    padding: EdgeInsets.all(8),
    decoration: boxDecorationWithRoundedCorners(backgroundColor: color!.withOpacity(0.2)),
    child: Icon(icon!, size: 14, color: color),
  ).onTap(() async {
    onCall!();
  });
}

Widget loading(){
  return Loader();
}
