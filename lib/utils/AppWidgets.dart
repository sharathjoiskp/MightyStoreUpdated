import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:nb_utils/nb_utils.dart';

import 'AppColors.dart';

BoxDecoration boxDecoration(BuildContext context, {double radius = 10, Color color = Colors.transparent, Color bgColor = white_color, var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: appStore.isDarkModeOn == true ? appStore.appBarColor : bgColor,
      boxShadow: showShadow ? [BoxShadow(color: Theme.of(context).hoverColor.withOpacity(0.2), blurRadius: 4, spreadRadius: 3, offset: Offset(1, 3))] : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

// ignore: must_be_immutable
class PriceWidget extends StatefulWidget {
  static String tag = '/PriceWidget';
  var price;
  double? size = 16.0;
  Color? color;
  var isLineThroughEnabled = false;

  PriceWidget({Key? key, this.price, this.color, this.size, this.isLineThroughEnabled = false}) : super(key: key);

  @override
  PriceWidgetState createState() => PriceWidgetState();
}

class PriceWidgetState extends State<PriceWidget> {
  String currency = '₹';
  Color? primaryColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLineThroughEnabled) {
      return Text('$currency ${widget.price.toString().replaceAll(".00", "")}', style: boldTextStyle(size: widget.size!.toInt(), color: widget.color != null ? widget.color : primaryColor));
    } else {
      return widget.price.toString().isNotEmpty
          ? Text('$currency${widget.price.toString().replaceAll(".00", "")}', style: TextStyle(fontSize: widget.size, color: widget.color ?? textPrimaryColor, decoration: TextDecoration.lineThrough))
          : Text('');
    }
  }
}

// ignore: must_be_immutable
class CustomTheme extends StatelessWidget {
  Widget? child;

  CustomTheme({this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkModeOn
          ? ThemeData.dark().copyWith(
              accentColor: colorPrimaryDark,
              backgroundColor: appStore.scaffoldBackground,
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}

Widget cachedImage(String? url, {double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius}) {
  if (url.validate().isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('images/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

// ignore: must_be_immutable
class CommonTextFormField extends StatefulWidget {
  bool isPassword;
  String labelText;
  bool isSecure;
  int fontSize;
  Color? textColor;
  String? fontFamily;
  String text;
  int maxLine;
  int minLine;
  final FormFieldValidator<String>? validator;
  Widget? suffixIcon;
  FocusNode? focusNode;
  TextInputType textInputType;
  TextEditingController? mController;
  String? prefixText;
  VoidCallback? onPressed;
  Function? onFieldSubmitted;
  bool readOnly;

  CommonTextFormField(
      {this.isPassword = false,
      this.labelText = "",
      this.isSecure = false,
      this.fontSize = 16,
      this.textColor,
      this.fontFamily,
      this.text = "",
      this.focusNode,
      this.suffixIcon,
      this.validator,
      this.onFieldSubmitted,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.minLine = 1,
      this.prefixText,
      this.mController,
      this.readOnly = false,
      this.onPressed});

  @override
  _CommonTextFormFieldState createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: widget.minLine,
      maxLines: widget.maxLine,
      keyboardType: widget.textInputType,
      controller: widget.mController,
      obscureText: widget.isPassword,
      onTap: widget.onPressed,
      validator: widget.validator,
      focusNode: widget.focusNode,
      cursorColor: primaryColor,
      onFieldSubmitted: widget.onFieldSubmitted as void Function(String)?,
      style: TextStyle(fontSize: widget.fontSize.toDouble(), fontFamily: widget.fontFamily, color: appStore.textPrimaryColor),
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color: appStore.iconColor,
                ),
              )
            : widget.suffixIcon,
        labelStyle: TextStyle(color: appStore.textSecondaryColor),
        labelText: widget.labelText,
        prefixText: widget.prefixText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: failedColor, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: failedColor, width: 1.0),
        ),
        errorMaxLines: 2,
        errorStyle: primaryTextStyle(color: failedColor, size: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: iconColorSecondary, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: primaryColor, width: 1.0),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NoDataFound extends StatelessWidget {
  String? title;
  Function? onPressed;

  NoDataFound({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset('images/ic_no_data.png', height: 150, width: 150),
          // 10.height,
          Text(title.validate(), style: primaryTextStyle()),
          20.height,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              textStyle: secondaryTextStyle(color: white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: onPressed as void Function()?,

            ///TODO
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}

Widget noDataWidget(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset('images/ic_no_data.png', height: 80, fit: BoxFit.fitHeight),
      8.height,
      Text('no_data_found'.translate, style: boldTextStyle()).center(),
    ],
  ).center();
}

InputDecoration inputDecoration(BuildContext context, String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    labelText: hint,
    labelStyle: secondaryTextStyle(),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: failedColor, width: 1.0)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: failedColor, width: 1.0)),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: failedColor, size: 12),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: iconColorSecondary, width: 1.0)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: primaryColor, width: 1.0)),
  );
}

Widget noInternet(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        MaterialCommunityIcons.wifi_off,
        size: 80,
      ),
      20.height,
      Text('No Internet', style: boldTextStyle(size: 24, color: Theme.of(context).textTheme.subtitle2!.color)),
      4.height,
      Text(
        "lbl_no_internet_msg".translate,
        style: secondaryTextStyle(size: 14, color: Theme.of(context).textTheme.subtitle1!.color),
        textAlign: TextAlign.center,
      ).paddingOnly(left: 20, right: 20),
    ],
  );
}
