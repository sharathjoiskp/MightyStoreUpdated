class SummaryResponse {
  int? pageviews;
  OrdersCount? ordersCount;
  String? sales;
  double? sellerBalance;

  SummaryResponse(
      {this.pageviews, this.ordersCount, this.sales, this.sellerBalance});

  SummaryResponse.fromJson(Map<String, dynamic> json) {
    pageviews = json['pageviews'];
    ordersCount = json['orders_count'] != null
        ? new OrdersCount.fromJson(json['orders_count'])
        : null;
    sales = json['sales'];
    sellerBalance = json['seller_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageviews'] = this.pageviews;
    if (this.ordersCount != null) {
      data['orders_count'] = this.ordersCount!.toJson();
    }
    data['sales'] = this.sales;
    data['seller_balance'] = this.sellerBalance;
    return data;
  }
}

class OrdersCount {
  int? wcPending;
  int? wcCompleted;
  int? wcOnHold;
  int? wcProcessing;
  int? wcRefunded;
  int? wcCancelled;
  int? total;

  OrdersCount(
      {this.wcPending,
        this.wcCompleted,
        this.wcOnHold,
        this.wcProcessing,
        this.wcRefunded,
        this.wcCancelled,
        this.total});

  OrdersCount.fromJson(Map<String, dynamic> json) {
    wcPending = json['wc-pending'];
    wcCompleted = json['wc-completed'];
    wcOnHold = json['wc-on-hold'];
    wcProcessing = json['wc-processing'];
    wcRefunded = json['wc-refunded'];
    wcCancelled = json['wc-cancelled'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wc-pending'] = this.wcPending;
    data['wc-completed'] = this.wcCompleted;
    data['wc-on-hold'] = this.wcOnHold;
    data['wc-processing'] = this.wcProcessing;
    data['wc-refunded'] = this.wcRefunded;
    data['wc-cancelled'] = this.wcCancelled;
    data['total'] = this.total;
    return data;
  }
}
