import 'package:mightyAdmin/models/OrderResponse.dart';

class VendorModel {
  List<OrderResponse>? order;
  OrderSummary? order_summary;
  ProductSummary? product_summary;

  VendorModel({this.order, this.order_summary, this.product_summary});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      order: json['order'] != null ? (json['order'] as List).map((i) => OrderResponse.fromJson(i)).toList() : null,
      order_summary: json['order_summary'] != null ? OrderSummary.fromJson(json['order_summary']) : null,
      product_summary: json['product_summary'] != null ? ProductSummary.fromJson(json['product_summary']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    if (this.order_summary != null) {
      data['order_summary'] = this.order_summary!.toJson();
    }
    if (this.product_summary != null) {
      data['product_summary'] = this.product_summary!.toJson();
    }
    return data;
  }
}

class Links {
  List<Collection>? collection;
  List<Customer>? customer;
  List<Self>? self;

  Links({this.collection, this.customer, this.self});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      collection: json['collection'] != null ? (json['collection'] as List).map((i) => Collection.fromJson(i)).toList() : null,
      customer: json['customer'] != null ? (json['customer'] as List).map((i) => Customer.fromJson(i)).toList() : null,
      self: json['self'] != null ? (json['self'] as List).map((i) => Self.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.map((v) => v.toJson()).toList();
    }
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
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

class Self {
  String? href;

  Self({this.href});

  factory Self.fromJson(Map<String, dynamic> json) {
    return Self(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class LineItem {
  int? id;
  List<MetaDataX>? meta_data;
  String? name;
  int? price;
  int? product_id;
  int? quantity;
  String? sku;
  String? subtotal;
  String? subtotal_tax;
  String? tax_class;
  String? total;
  String? total_tax;
  int? variation_id;

  LineItem({this.id, this.meta_data, this.name, this.price, this.product_id, this.quantity, this.sku, this.subtotal, this.subtotal_tax, this.tax_class, this.total, this.total_tax, this.variation_id});

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'],
      meta_data: json['meta_data'] != null ? (json['meta_data'] as List).map((i) => MetaDataX.fromJson(i)).toList() : null,
      name: json['name'],
      price: json['price'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      sku: json['sku'],
      subtotal: json['subtotal'],
      subtotal_tax: json['subtotal_tax'],
      tax_class: json['tax_class'],
      total: json['total'],
      total_tax: json['total_tax'],
      variation_id: json['variation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_id'] = this.product_id;
    data['quantity'] = this.quantity;
    data['sku'] = this.sku;
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotal_tax;
    data['tax_class'] = this.tax_class;
    data['total'] = this.total;
    data['total_tax'] = this.total_tax;
    data['variation_id'] = this.variation_id;
    if (this.meta_data != null) {
      data['meta_data'] = this.meta_data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      id: json['id'],
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Shipping {
  String? address_1;
  String? address_2;
  String? city;
  String? company;
  String? country;
  String? first_name;
  String? last_name;
  String? postcode;
  String? state;

  Shipping({this.address_1, this.address_2, this.city, this.company, this.country, this.first_name, this.last_name, this.postcode, this.state});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      address_1: json['address_1'],
      address_2: json['address_2'],
      city: json['city'],
      company: json['company'],
      country: json['country'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      postcode: json['postcode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_1'] = this.address_1;
    data['address_2'] = this.address_2;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country'] = this.country;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    return data;
  }
}

class MetaDataX {
  int? id;
  String? key;
  String? value;

  MetaDataX({this.id, this.key, this.value});

  factory MetaDataX.fromJson(Map<String, dynamic> json) {
    return MetaDataX(
      id: json['id'],
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Billing {
  String? address_1;
  String? address_2;
  String? city;
  String? company;
  String? country;
  String? email;
  String? first_name;
  String? last_name;
  String? phone;
  String? postcode;
  String? state;

  Billing({this.address_1, this.address_2, this.city, this.company, this.country, this.email, this.first_name, this.last_name, this.phone, this.postcode, this.state});

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      address_1: json['address_1'],
      address_2: json['address_2'],
      city: json['city'],
      company: json['company'],
      country: json['country'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      phone: json['phone'],
      postcode: json['postcode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_1'] = this.address_1;
    data['address_2'] = this.address_2;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country'] = this.country;
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['phone'] = this.phone;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    return data;
  }
}

class OrderSummary {
  int? total;
  int? wc_cancelled;
  int? wc_completed;
  int? wc_failed;
  int? wc_on_hold;
  int? wc_pending;
  int? wc_processing;
  int? wc_refunded;

  OrderSummary({this.total, this.wc_cancelled, this.wc_completed, this.wc_failed, this.wc_on_hold, this.wc_pending, this.wc_processing, this.wc_refunded});

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      total: json['total'],
      wc_cancelled: json['wc-cancelled'],
      wc_completed: json['wc-completed'],
      wc_failed: json['wc-failed'],
      wc_on_hold: json['wc-on-hold'],
      wc_pending: json['wc-pending'],
      wc_processing: json['wc-processing'],
      wc_refunded: json['wc-refunded'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['wc-cancelled'] = this.wc_cancelled;
    data['wc-completed'] = this.wc_completed;
    data['wc-failed'] = this.wc_failed;
    data['wc-on-hold'] = this.wc_on_hold;
    data['wc-pending'] = this.wc_pending;
    data['wc-processing'] = this.wc_processing;
    data['wc-refunded'] = this.wc_refunded;
    return data;
  }
}

class ProductSummary {
  PostCounts? post_counts;
  String? products_url;

  ProductSummary({this.post_counts, this.products_url});

  factory ProductSummary.fromJson(Map<String, dynamic> json) {
    return ProductSummary(
      post_counts: json['post_counts'] != null ? PostCounts.fromJson(json['post_counts']) : null,
      products_url: json['products_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_url'] = this.products_url;
    if (this.post_counts != null) {
      data['post_counts'] = this.post_counts!.toJson();
    }
    return data;
  }
}

class PostCounts {
  int? private;
  int? auto_draft;
  int? draft;
  int? future;
  int? inherit;
  int? pending;
  int? publish;
  int? request_completed;
  int? request_confirmed;
  int? request_failed;
  int? request_pending;
  int? total;
  int? trash;

  PostCounts({this.private, this.auto_draft, this.draft, this.future, this.inherit, this.pending, this.publish, this.request_completed, this.request_confirmed, this.request_failed, this.request_pending, this.total, this.trash});

  factory PostCounts.fromJson(Map<String, dynamic> json) {
    return PostCounts(
      private: json['private'],
      auto_draft: json['auto-draft'],
      draft: json['draft'],
      future: json['future'],
      inherit: json['inherit'],
      pending: json['pending'],
      publish: json['publish'],
      request_completed: json['request-completed'],
      request_confirmed: json['request-confirmed'],
      request_failed: json['request-failed'],
      request_pending: json['request-pending'],
      total: json['total'],
      trash: json['trash'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['private'] = this.private;
    data['auto-draft'] = this.auto_draft;
    data['draft'] = this.draft;
    data['future'] = this.future;
    data['inherit'] = this.inherit;
    data['pending'] = this.pending;
    data['publish'] = this.publish;
    data['request-completed'] = this.request_completed;
    data['request-confirmed'] = this.request_confirmed;
    data['request-failed'] = this.request_failed;
    data['request-pending'] = this.request_pending;
    data['total'] = this.total;
    data['trash'] = this.trash;
    return data;
  }
}
