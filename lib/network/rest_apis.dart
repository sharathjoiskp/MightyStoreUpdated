import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyAdmin/main.dart';
import 'package:mightyAdmin/models/AttributeModel.dart';
import 'package:mightyAdmin/models/CategoryResponse.dart';
import 'package:mightyAdmin/models/CustomerResponse.dart';
import 'package:mightyAdmin/models/DeleteCustomerResponse.dart';
import 'package:mightyAdmin/models/DeleteReviewResponse.dart';
import 'package:mightyAdmin/models/LoginResponse.dart';
import 'package:mightyAdmin/models/OrderNotesResponse.dart';
import 'package:mightyAdmin/models/OrderResponse.dart';
import 'package:mightyAdmin/models/ProductDetailResponse.dart';
import 'package:mightyAdmin/models/ReviewResponse.dart';
import 'package:mightyAdmin/models/UpdateReviewResponse.dart';
import 'package:mightyAdmin/models/VendorModel.dart';
import 'package:mightyAdmin/network/vendor_api.dart';
import 'package:mightyAdmin/screens/SignInScreen.dart';
import 'package:mightyAdmin/utils/AppColors.dart';
import 'package:mightyAdmin/utils/AppCommon.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'NetworkUtils.dart';

String dashboardUrl = '';

Future<LoginResponse> login(request) async {
  return await handleResponse(await VendorAPI().postAsync('jwt-auth/v1/token', request)).then((res) async {
    LoginResponse loginResponse = LoginResponse.fromJson(res);
    String role = '';

    loginResponse.userRole!.forEach((element) {
      role = element.validate();
    });

    if (role == 'administrator') {
      toast('Admin');
      dashboardUrl = currentUrl = adminUrl;
      await setValue(USER_ID, loginResponse.userId);
      await setValue(FIRST_NAME, loginResponse.firstName);
      await setValue(LAST_NAME, loginResponse.lastName);
      await setValue(USER_EMAIL, loginResponse.userEmail);
      await setValue(USERNAME, loginResponse.userNiceName);
      await setValue(TOKEN, loginResponse.token);
      await setValue(AVATAR, loginResponse.avatar);
      await setStringAsync(USER_ROLE, role);
      if (loginResponse.profileImage != null) {
        await setValue(PROFILE_IMAGE, loginResponse.profileImage);
      }
      await setValue(USER_DISPLAY_NAME, loginResponse.profileImage);

      await setValue(IS_LOGGED_IN, true);

      appStore.setLoggedIn(true);
    } else if (role == 'seller') {
      toast('Vendor');
      currentUrl = vendorUrl;

      await setValue(USER_ID, loginResponse.userId);
      await setValue(FIRST_NAME, loginResponse.firstName);
      await setValue(LAST_NAME, loginResponse.lastName);
      await setValue(USER_EMAIL, loginResponse.userEmail);
      await setValue(USERNAME, loginResponse.userNiceName);
      await setValue(TOKEN, loginResponse.token);
      await setValue(AVATAR, loginResponse.avatar);
      await setStringAsync(USER_ROLE, role);

      if (loginResponse.profileImage != null) {
        await setValue(PROFILE_IMAGE, loginResponse.profileImage);
      }
      await setValue(USER_DISPLAY_NAME, loginResponse.profileImage);

      await setValue(IS_LOGGED_IN, true);

      appStore.setLoggedIn(true);
    } else {
      toast('This app for only the admin');
    }
    return loginResponse;
  });
}

Future getDashboard({String? dateMin, String? dateMax, String? topDateMin, String? topDateMax, String? period = 'week'}) async {
  return handleResponse(
      await VendorAPI().getAsync('store/api/v1/woocommerce/get-admin-dashboard?date_min=$dateMin&date_max=$dateMax&cs=$ConsumerSecret&ck=$ConsumerKey&period=$period', requireToken: true));
}

Future<VendorModel> getVendorDashboard() async {
  return VendorModel.fromJson(await handleResponse(await VendorAPI().getAsync('store/api/v1/woocommerce/get-vendor-dashboard?$ConsumerSecret&ck=$ConsumerKey', requireToken: true)));
}

Future createCustomer(request) async {
  return handleResponse(await VendorAPI().postAsync('mightystore/api/v1/woocommerce/customer/register', request));
}

Future<List<OrderResponse>> getOrders(int page) async {
  Iterable it = await (handleResponse(await VendorAPI().getAsync('$currentUrl/orders?page=$page&per_page=$perPage', requireToken: true)));
  return it.map((e) => OrderResponse.fromJson(e)).toList();
}

Future updateOrder(id, request) async {
  return handleResponse(await VendorAPI().putAsync('$currentUrl/orders/$id', data: request, requireToken: true));
}

Future<List<CategoryResponse>> getAllCategory({int? page}) async {
  Iterable mCategory = await (handleResponse(await VendorAPI().getAsync('$adminUrl/products/categories?page=$page&per_page=$perPage', requireToken: true)));
  return mCategory.map((model) => CategoryResponse.fromJson(model)).toList();
}

Future<List<CategoryResponse>> getSubCategories(parent) async {
  Iterable mCategory = await (handleResponse(await VendorAPI().getAsync('$currentUrl/products/categories?parent=$parent&per_page=$perPage', requireToken: true)));
  return mCategory.map((model) => CategoryResponse.fromJson(model)).toList();
}

Future<CategoryResponse> addCategory(request) async {
  var d = await handleResponse(await VendorAPI().postAsync('$currentUrl/products/categories', request, requireToken: true));
  return CategoryResponse.fromJson(d);
}

Future<void> updateCategory(pId, request) async {
  return handleResponse(await VendorAPI().putAsync('$currentUrl/products/categories/$pId', data: request, requireToken: true));
}

Future<void> deleteCategory({int? categoryId}) async {
  return handleResponse(await VendorAPI().deleteAsync('$currentUrl/products/categories/$categoryId?force=true', requireToken: true));
}

Future<List<ReviewResponse>> getAllReview({int? page}) async {
  Iterable review = await (handleResponse(await VendorAPI().getAsync('$currentUrl/products/reviews?page=$page&per_page=$perPage', requireToken: true)));
  return review.map((model) => ReviewResponse.fromJson(model)).toList();
}

Future<UpdateReviewResponse> updateReview({Map? request, int? reviewId}) async {
  var s = await handleResponse(await VendorAPI().putAsync('$currentUrl/products/reviews/$reviewId', data: request, requireToken: true));
  String temp = jsonEncode(s);
  return UpdateReviewResponse.fromJson(jsonDecode(temp));
}

Future<DeleteReviewResponse> deleteReview({int? reviewId}) async {
  var s = await handleResponse(await VendorAPI().deleteAsync('$currentUrl/products/reviews/$reviewId', requireToken: true));
  String temp = jsonEncode(s);
  return DeleteReviewResponse.fromJson(jsonDecode(temp));
}

Future<List<AttributeModel>> getAllProductAttributes({int? page}) async {
  Iterable attributes = await (handleResponse(await VendorAPI().getAsync('$currentUrl/products/attributes?page=$page&per_page=$perPage', requireToken: true)));
  return attributes.map((model) => AttributeModel.fromJson(model)).toList();
}

Future<List<AttributeModel>> getAllAttributesTerms({int? id, int? page}) async {
  Iterable attributes = await (handleResponse(await VendorAPI().getAsync('$currentUrl/products/attributes/$id/terms?page=$page&per_page=$perPage', requireToken: true)));
  return attributes.map((model) => AttributeModel.fromJson(model)).toList();
}

Future<AttributeModel> addAttribute({Map? req, int? attributeId}) async {
  var s = await handleResponse(await VendorAPI().postAsync('$currentUrl/products/attributes', req, requireToken: true));
  return AttributeModel.fromJson(s);
}

Future<AttributeModel> addTerm({Map? req, int? attributeId}) async {
  var s = await handleResponse(await VendorAPI().postAsync('$currentUrl/products/attributes/$attributeId/terms', req, requireToken: true));
  return AttributeModel.fromJson(s);
}

Future<AttributeModel> editAttribute({Map? request, int? attributeId, int? attributeTermId}) async {
  var s = await handleResponse(await VendorAPI().putAsync('$currentUrl/products/attributes/$attributeId', data: request, requireToken: true));
  return AttributeModel.fromJson(s);
}

Future<AttributeModel> editTerms({Map? request, int? attributeId, int? attributeTermId}) async {
  var s = await handleResponse(await VendorAPI().putAsync('$currentUrl/products/attributes/$attributeId/terms/$attributeTermId', data: request, requireToken: true));
  return AttributeModel.fromJson(s);
}

Future<AttributeModel> deleteAttributesTerm({int? attributeId, int? attributeTermId, bool isAttribute = false}) async {
  var s = await handleResponse(await VendorAPI()
      .deleteAsync(isAttribute ? '$currentUrl/products/attributes/$attributeId?force=true' : '$currentUrl/products/attributes/$attributeId/terms/$attributeTermId?force=true', requireToken: true));
  return AttributeModel.fromJson(s);
}

Future<List<CustomerResponse>> getAllCustomer({int? page}) async {
  Iterable e = await (handleResponse(await VendorAPI().getAsync('$currentUrl/customers?page=$page&per_page=$perPage', requireToken: true)));
  return e.map((model) => CustomerResponse.fromJson(model)).toList();
}

Future<CustomerResponse> addCustomer(Map req) async {
  var s = await handleResponse(await VendorAPI().postAsync('$currentUrl/customers', req, requireToken: true));
  return CustomerResponse.fromJson(s);
}

Future<CustomerResponse> editCustomer({int? customerId, Map? request}) async {
  var s = await handleResponse(await VendorAPI().putAsync('$currentUrl/customers/$customerId', data: request, requireToken: true));
  String temp = jsonEncode(s);
  return CustomerResponse.fromJson(jsonDecode(temp));
}

Future<DeleteCustomerResponse> deleteCustomer({int? customerId}) async {
  var s = await handleResponse(await VendorAPI().deleteAsync('$currentUrl/customers/$customerId?force=true', requireToken: true));
  String temp = jsonEncode(s);
  return DeleteCustomerResponse.fromJson(jsonDecode(temp));
}

Future<List<ProductDetailResponse1>> getAllProducts(int? page) async {
  Iterable it = await (handleResponse(await VendorAPI().getAsync('$currentUrl/products/?page=$page&per_page=$perPage', requireToken: true)));
  return it.map((e) => ProductDetailResponse1.fromJson(e)).toList();
}

Future<List<Images1>> getMediaImage(int page) async {
  Iterable it = await (handleResponse(await VendorAPI().getAsync('wp/v2/media/?page=$page&per_page=$ImgPerPage', requireToken: true)));
  return it.map((e) => Images1.fromJson(e)).toList();
}

Future createProduct(request) async {
  return handleResponse(await VendorAPI().postAsync('$currentUrl/products', request, requireToken: true));
}

Future updateProduct(pId, request) async {
  return handleResponse(await VendorAPI().postAsync('$currentUrl/products/$pId', request, requireToken: true));
}

Future deleteProduct(pId) async {
  return handleResponse(await VendorAPI().deleteAsync('$currentUrl/products/$pId'));
}

Future getVariation(pid) async {
  return handleResponse(await VendorAPI().getAsync('$currentUrl/products/$pid/variations'));
}

Future createVariation(pid, request) async {
  return handleResponse(await VendorAPI().postAsync('$currentUrl/products/$pid/variations/batch', request));
}

Future deleteVariation(pid, request) async {
  return handleResponse(await VendorAPI().postAsync('$currentUrl/wp-json/wc/v3/products/$pid/variations', request));
}

Future getAllAttribute() async {
  return handleResponse(await VendorAPI().getAsync('$currentUrl/products/attributes'));
}

Future getAllAttributeTerms(id) async {
  return handleResponse(await VendorAPI().getAsync('$currentUrl/products/attributes/$id/terms'));
}

Future getProductDetail(int? productId) async {
  return handleResponse(await VendorAPI().getAsync('$currentUrl/products/$productId', requireToken: true));
}

Future<List<OrderNotesResponse>> getOrderNotes(int? orderId) async {
  Iterable it = await (handleResponse(await VendorAPI().getAsync('$currentUrl/orders/$orderId/notes/', requireToken: true)));
  return it.map((e) => OrderNotesResponse.fromJson(e)).toList();
}

Future<void> logout(BuildContext context) async {
  showConfirmDialogCustom(
    context,
    title: "logout_confirmation".translate,
    primaryColor: primaryColor,
    onAccept: (_) async {
      await removeKey(TOKEN);
      await removeKey(USER_ID);
      await removeKey(FIRST_NAME);
      await removeKey(LAST_NAME);
      await removeKey(USERNAME);
      await removeKey(USER_DISPLAY_NAME);
      await removeKey(PROFILE_IMAGE);
      await removeKey(IS_LOGGED_IN);

      appStore.setLoggedIn(false);

      5.milliseconds;
      SignInScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
    },
    dialogType: DialogType.CONFIRMATION,
    negativeText: 'lbl_cancel'.translate,
    positiveText: 'lbl_Yes'.translate,
  );
}

// Dashboard API
Future getOrderSummary() async {
  return handleResponse(await VendorAPI().getAsync('$vendorUrl/orders/summary', requireToken: true));
}

Future getProductSummary() async {
  return handleResponse(await VendorAPI().getAsync('$vendorUrl/products/summary', requireToken: true));
}

Future getReportSummary() async {
  return handleResponse(await VendorAPI().getAsync('$vendorUrl/reports/top_selling?start_date=2018-01-01', requireToken: true));
}

Future getVendorOrder() async {
  return handleResponse(await VendorAPI().getAsync('$vendorUrl/orders', requireToken: true));
}
