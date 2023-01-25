import 'BillingModel.dart';
import 'OrderResponse.dart';
import 'ShippingModel.dart';

class DashboardResponse {
  List<CustomerTotal>? customerTotal;
  List<NewComment>? newComment;
  List<NewOrder>? newOrder;
  List<OrderTotal>? orderTotal;
  List<ProductsTotal>? productsTotal;
  List<ReviewsTotal>? reviewsTotal;
  List<SaleReport>? saleReport;
  List<TopSaleReport>? topSaleReport;

  DashboardResponse({this.customerTotal, this.newComment, this.newOrder, this.orderTotal, this.productsTotal, this.reviewsTotal, this.saleReport, this.topSaleReport});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      customerTotal: json['customer_total'] != null ? (json['customer_total'] as List).map((i) => CustomerTotal.fromJson(i)).toList() : null,
      newComment: json['new_comment'] != null ? (json['new_comment'] as List).map((i) => NewComment.fromJson(i)).toList() : null,
      newOrder: json['new_order'] != null ? (json['new_order'] as List).map((i) => NewOrder.fromJson(i)).toList() : null,
      orderTotal: json['order_total'] != null ? (json['order_total'] as List).map((i) => OrderTotal.fromJson(i)).toList() : null,
      productsTotal: json['products_total'] != null ? (json['products_total'] as List).map((i) => ProductsTotal.fromJson(i)).toList() : null,
      reviewsTotal: json['reviews_total'] != null ? (json['reviews_total'] as List).map((i) => ReviewsTotal.fromJson(i)).toList() : null,
      saleReport: json['sale_report'] != null ? (json['sale_report'] as List).map((i) => SaleReport.fromJson(i)).toList() : null,
      topSaleReport: json['top_sale_report'] != null ? (json['top_sale_report'] as List).map((i) => TopSaleReport.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerTotal != null) {
      data['customer_total'] = this.customerTotal!.map((v) => v.toJson()).toList();
    }
    if (this.newComment != null) {
      data['new_comment'] = this.newComment!.map((v) => v.toJson()).toList();
    }
    if (this.newOrder != null) {
      data['new_order'] = this.newOrder!.map((v) => v.toJson()).toList();
    }
    if (this.orderTotal != null) {
      data['order_total'] = this.orderTotal!.map((v) => v.toJson()).toList();
    }
    if (this.productsTotal != null) {
      data['products_total'] = this.productsTotal!.map((v) => v.toJson()).toList();
    }
    if (this.reviewsTotal != null) {
      data['reviews_total'] = this.reviewsTotal!.map((v) => v.toJson()).toList();
    }
    if (this.saleReport != null) {
      data['sale_report'] = this.saleReport!.map((v) => v.toJson()).toList();
    }
    if (this.topSaleReport != null) {
      data['top_sale_report'] = this.topSaleReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsTotal {
  String? name;
  String? slug;
  var total;

  ProductsTotal({this.name, this.slug, this.total});

  factory ProductsTotal.fromJson(Map<String, dynamic> json) {
    return ProductsTotal(
      name: json['name'],
      slug: json['slug'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['total'] = this.total;
    return data;
  }
}

class TopSaleReport {
  String? averageSales;
  String? netSales;
  var totalCustomers;
  String? totalDiscount;
  var totalItems;
  var totalOrders;
  var totalRefunds;
  String? totalSales;
  String? totalShipping;
  String? totalTax;
  String? totalsGroupedBy;

  TopSaleReport(
      {this.averageSales, this.netSales, this.totalCustomers, this.totalDiscount, this.totalItems, this.totalOrders, this.totalRefunds, this.totalSales, this.totalShipping, this.totalTax, this.totalsGroupedBy});

  factory TopSaleReport.fromJson(Map<String, dynamic> json) {
    return TopSaleReport(
      averageSales: json['average_sales'],
      netSales: json['net_sales'],
      totalCustomers: json['total_customers'],
      totalDiscount: json['total_discount'],
      totalItems: json['total_items'],
      totalOrders: json['total_orders'],
      totalRefunds: json['total_refunds'],
      totalSales: json['total_sales'],
      totalShipping: json['total_shipping'],
      totalTax: json['total_tax'],
      totalsGroupedBy: json['totals_grouped_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_sales'] = this.averageSales;
    data['net_sales'] = this.netSales;
    data['total_customers'] = this.totalCustomers;
    data['total_discount'] = this.totalDiscount;
    data['total_items'] = this.totalItems;
    data['total_orders'] = this.totalOrders;
    data['total_refunds'] = this.totalRefunds;
    data['total_sales'] = this.totalSales;
    data['total_shipping'] = this.totalShipping;
    data['total_tax'] = this.totalTax;
    data['totals_grouped_by'] = this.totalsGroupedBy;
    return data;
  }
}

class OrderTotal {
  String? name;
  String? slug;
  var total;

  OrderTotal({this.name, this.slug, this.total});

  factory OrderTotal.fromJson(Map<String, dynamic> json) {
    return OrderTotal(
      name: json['name'],
      slug: json['slug'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['total'] = this.total;
    return data;
  }
}

class NewOrder {
  Billing? billing;
  String? cartHash;
  String? cartTax;
  String? createdVia;
  String? currency;
  String? currencySymbol;
  var customerId;
  String? customerIpAddress;
  String? customerNote;
  String? customerUserAgent;
  String? dateCompleted;
  String? dateCompletedGmt;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? datePaid;
  String? datePaidGmt;
  String? discountTax;
  String? discountTotal;
  var id;
  List<LineItem>? lineItems;
  String? number;
  String? orderKey;
  var parentId;
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? pricesIncludeTax;
  Shipping? shipping;
  List<ShippingLine>? shippingLines;
  String? shippingTax;
  String? shippingTotal;
  String? status;
  Store? store;
  List<Store>? stores;
  String? total;
  String? totalTax;
  String? transactionId;
  String? version;

  NewOrder(
      {this.billing,
      this.cartHash,
      this.cartTax,
      this.createdVia,
      this.currency,
      this.currencySymbol,
      this.customerId,
      this.customerIpAddress,
      this.customerNote,
      this.customerUserAgent,
      this.dateCompleted,
      this.dateCompletedGmt,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.datePaid,
      this.datePaidGmt,
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
      this.shippingLines,
      this.shippingTax,
      this.shippingTotal,
      this.status,
      this.store,
      this.stores,
      this.total,
      this.totalTax,
      this.transactionId,
      this.version});

  factory NewOrder.fromJson(Map<String, dynamic> json) {
    return NewOrder(
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
      dateCompleted: json['date_completed'],
      dateCompletedGmt: json['date_completed_gmt'],
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      dateModified: json['date_modified'],
      dateModifiedGmt: json['date_modified_gmt'],
      datePaid: json['date_paid'],
      datePaidGmt: json['date_paid_gmt'],
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
      shippingLines: json['shipping_lines'] != null ? (json['shipping_lines'] as List).map((i) => ShippingLine.fromJson(i)).toList() : null,
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
    data['date_completed'] = this.dateCompleted;
    data['date_completed_gmt'] = this.dateCompletedGmt;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['date_paid'] = this.datePaid;
    data['date_paid_gmt'] = this.datePaidGmt;
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
    if (this.shippingLines != null) {
      data['shipping_lines'] = this.shippingLines!.map((v) => v.toJson()).toList();
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

class ShippingLine {
  var id;
  String? instanceId;
  String? methodId;
  String? methodTitle;
  String? total;
  String? totalTax;

  ShippingLine({this.id, this.instanceId, this.methodId, this.methodTitle, this.total, this.totalTax});

  factory ShippingLine.fromJson(Map<String, dynamic> json) {
    return ShippingLine(
      id: json['id'],
      instanceId: json['instance_id'],
      methodId: json['method_id'],
      methodTitle: json['method_title'],
      total: json['total'],
      totalTax: json['total_tax'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instance_id'] = this.instanceId;
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    return data;
  }
}

class Customer {
  String? href;

  Customer({this.href});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}


class SaleReport {
  String? averageSales;
  String? netSales;
  var totalCustomers;
  String? totalDiscount;
  var totalItems;
  var totalOrders;
  var totalRefunds;
  String? totalSales;
  String? totalShipping;
  String? totalTax;
  String? totalsGroupedBy;

  SaleReport({this.averageSales, this.netSales, this.totalCustomers, this.totalDiscount, this.totalItems, this.totalOrders, this.totalRefunds, this.totalSales, this.totalShipping, this.totalTax, this.totalsGroupedBy});

  factory SaleReport.fromJson(Map<String, dynamic> json) {
    return SaleReport(
      averageSales: json['average_sales'],
      netSales: json['net_sales'],
      totalCustomers: json['total_customers'],
      totalDiscount: json['total_discount'],
      totalItems: json['total_items'],
      totalOrders: json['total_orders'],
      totalRefunds: json['total_refunds'],
      totalSales: json['total_sales'],
      totalShipping: json['total_shipping'],
      totalTax: json['total_tax'],
      totalsGroupedBy: json['totals_grouped_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_sales'] = this.averageSales;
    data['net_sales'] = this.netSales;
    data['total_customers'] = this.totalCustomers;
    data['total_discount'] = this.totalDiscount;
    data['total_items'] = this.totalItems;
    data['total_orders'] = this.totalOrders;
    data['total_refunds'] = this.totalRefunds;
    data['total_sales'] = this.totalSales;
    data['total_shipping'] = this.totalShipping;
    data['total_tax'] = this.totalTax;
    data['totals_grouped_by'] = this.totalsGroupedBy;
    return data;
  }

}

class NewComment {
  String? commentID;
  String? commentAgent;
  String? commentApproved;
  String? commentAuthor;
  String? commentAuthorIP;
  String? commentAuthorEmail;
  String? commentAuthorUrl;
  String? commentContent;
  String? commentDate;
  String? commentDateGmt;
  String? commentKarma;
  String? commentParent;
  String? commentPostID;
  String? commentType;
  String? userId;

  NewComment(
      {this.commentID,
      this.commentAgent,
      this.commentApproved,
      this.commentAuthor,
      this.commentAuthorIP,
      this.commentAuthorEmail,
      this.commentAuthorUrl,
      this.commentContent,
      this.commentDate,
      this.commentDateGmt,
      this.commentKarma,
      this.commentParent,
      this.commentPostID,
      this.commentType,
      this.userId});

  factory NewComment.fromJson(Map<String, dynamic> json) {
    return NewComment(
      commentID: json['comment_ID'],
      commentAgent: json['comment_agent'],
      commentApproved: json['comment_approved'],
      commentAuthor: json['comment_author'],
      commentAuthorIP: json['comment_author_IP'],
      commentAuthorEmail: json['comment_author_email'],
      commentAuthorUrl: json['comment_author_url'],
      commentContent: json['comment_content'],
      commentDate: json['comment_date'],
      commentDateGmt: json['comment_date_gmt'],
      commentKarma: json['comment_karma'],
      commentParent: json['comment_parent'],
      commentPostID: json['comment_post_ID'],
      commentType: json['comment_type'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_ID'] = this.commentID;
    data['comment_agent'] = this.commentAgent;
    data['comment_approved'] = this.commentApproved;
    data['comment_author'] = this.commentAuthor;
    data['comment_author_IP'] = this.commentAuthorIP;
    data['comment_author_email'] = this.commentAuthorEmail;
    data['comment_author_url'] = this.commentAuthorUrl;
    data['comment_content'] = this.commentContent;
    data['comment_date'] = this.commentDate;
    data['comment_date_gmt'] = this.commentDateGmt;
    data['comment_karma'] = this.commentKarma;
    data['comment_parent'] = this.commentParent;
    data['comment_post_ID'] = this.commentPostID;
    data['comment_type'] = this.commentType;
    data['user_id'] = this.userId;
    return data;
  }
}

class CustomerTotal {
  String? name;
  String? slug;
  var total;

  CustomerTotal({this.name, this.slug, this.total});

  factory CustomerTotal.fromJson(Map<String, dynamic> json) {
    return CustomerTotal(
      name: json['name'],
      slug: json['slug'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['total'] = this.total;
    return data;
  }
}

class ReviewsTotal {
  String? name;
  String? slug;
  var total;

  ReviewsTotal({this.name, this.slug, this.total});

  factory ReviewsTotal.fromJson(Map<String, dynamic> json) {
    return ReviewsTotal(
      name: json['name'],
      slug: json['slug'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['total'] = this.total;
    return data;
  }
}

class SaleTotalData {
  String? key;
  var customers;
  String? discount;
  var items;
  var orders;
  String? sales;
  String? shipping;
  String? tax;

  SaleTotalData({this.key,this.customers, this.discount, this.items, this.orders, this.sales, this.shipping, this.tax});

  factory SaleTotalData.fromJson(Map<String, dynamic> json) {
    return SaleTotalData(
      customers: json['customers'],
      discount: json['discount'],
      items: json['items'],
      orders: json['orders'],
      sales: json['sales'],
      shipping: json['shipping'],
      tax: json['tax'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customers'] = this.customers;
    data['discount'] = this.discount;
    data['items'] = this.items;
    data['orders'] = this.orders;
    data['sales'] = this.sales;
    data['shipping'] = this.shipping;
    data['tax'] = this.tax;
    data['key'] = this.key;
    return data;
  }
}
