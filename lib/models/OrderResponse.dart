import 'BillingModel.dart';
import 'ProductResponse.dart';
import 'ShippingModel.dart';

class OrderResponse {
  Billing? billing;
  String? cartHash;
  String? cartTax;
  String? createdVia;
  String? currency;
  String? currencySymbol;
  int? customerId;
  String? customerIpAddress;
  String? customerNote;
  String? customerUserAgent;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? discountTax;
  String? discountTotal;
  int? id;
  List<LineItem>? lineItems;
  String? number;
  String? orderKey;
  int? parentId;
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? pricesIncludeTax;
  Shipping? shipping;
  String? shippingTax;
  String? shippingTotal;
  String? status;
  Store? store;
  List<Store>? stores;
  String? total;
  String? totalTax;
  String? transactionId;
  String? version;

  OrderResponse({
    this.billing,
    this.cartHash,
    this.cartTax,
    this.createdVia,
    this.currency,
    this.currencySymbol,
    this.customerId,
    this.customerIpAddress,
    this.customerNote,
    this.customerUserAgent,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTax,
    this.discountTotal,
    this.id,
    this.lineItems,
    this.number,
    this.orderKey,
    this.parentId,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.pricesIncludeTax,
    this.shipping,
    this.shippingTax,
    this.shippingTotal,
    this.status,
    this.store,
    this.stores,
    this.total,
    this.totalTax,
    this.transactionId,
    this.version,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      billing: json['billing'] != null ? Billing.fromJson(json['billing']) : null,
      cartHash: json['cart_hash'],
      cartTax: json['cart_tax'],
      createdVia: json['created_via'],
      currency: json['currency'],
      currencySymbol: json['currency_symbol'],
      customerId: json['customer_id'],
      customerIpAddress: json['customer_ip_address'],
      customerNote: json['customer_note'],
      customerUserAgent: json['customer_user_agent'],
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      dateModified: json['date_modified'],
      dateModifiedGmt: json['date_modified_gmt'],
      discountTax: json['discount_tax'],
      discountTotal: json['discount_total'],
      id: json['id'],
     lineItems: json['line_items'] != null ? (json['line_items'] as List).map((i) => LineItem.fromJson(i)).toList() : null,
      number: json['number'],
      orderKey: json['order_key'],
      parentId: json['parent_id'],
      paymentMethod: json['payment_method'],
      paymentMethodTitle: json['payment_method_title'],
      pricesIncludeTax: json['prices_include_tax'],
      shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
      shippingTax: json['shipping_tax'],
      shippingTotal: json['shipping_total'],
      status: json['status'],
      store: (json['store'] != null && (json['store'] is Map)) ? Store.fromJson(json['store']) : null,
      stores: json['stores'] != null ? (json['stores'] as List).map((i) => Store.fromJson(i)).toList() : null,
      total: json['total'],
      totalTax: json['total_tax'],
      transactionId: json['transaction_id'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_hash'] = this.cartHash;
    data['cart_tax'] = this.cartTax;
    data['created_via'] = this.createdVia;
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currencySymbol;
    data['customer_id'] = this.customerId;
    data['customer_ip_address'] = this.customerIpAddress;
    data['customer_note'] = this.customerNote;
    data['customer_user_agent'] = this.customerUserAgent;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['discount_tax'] = this.discountTax;
    data['discount_total'] = this.discountTotal;
    data['id'] = this.id;
    data['number'] = this.number;
    data['order_key'] = this.orderKey;
    data['parent_id'] = this.parentId;
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['prices_include_tax'] = this.pricesIncludeTax;
    data['shipping_tax'] = this.shippingTax;
    data['shipping_total'] = this.shippingTotal;
    data['status'] = this.status;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['transaction_id'] = this.transactionId;
    data['version'] = this.version;
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItem {
  var id;
  List<MetaData>? metaData;
  String? name;
  var price;
  var productId;
  var quantity;
  String? sku;
  String? subtotal;
  String? subtotalTax;
  String? taxClass;
  String? total;
  String? totalTax;
  var variationId;

  LineItem({this.id, this.metaData, this.name, this.price, this.productId, this.quantity, this.sku, this.subtotal, this.subtotalTax, this.taxClass, this.total, this.totalTax, this.variationId});

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'],
      metaData: json['meta_data'] != null ? (json['meta_data'] as List).map((i) => MetaData.fromJson(i)).toList() : null,
      name: json['name'],
      price: json['price'],
      productId: json['product_id'],
      quantity: json['quantity'],
      sku: json['sku'],
      subtotal: json['subtotal'],
      subtotalTax: json['subtotal_tax'],
      taxClass: json['tax_class'],
      total: json['total'],
      totalTax: json['total_tax'],
      variationId: json['variation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['sku'] = this.sku;
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['tax_class'] = this.taxClass;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['variation_id'] = this.variationId;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  String? shopName;

  Store({this.shopName});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      shopName: json['shop_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_name'] = this.shopName;
    return data;
  }
}
