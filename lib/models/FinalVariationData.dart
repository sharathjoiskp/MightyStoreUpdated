import 'ProductDetailResponse.dart';

class FinalVariationData {
  String? regularPrice;
  String? salePrice;
  String? status;
  String? description;
  String? dateOnSaleFrom;
  String? dateOnSaleTo;
  List<Images1>? images;
  List<VariationAttributeData>? attributes = [];

  FinalVariationData({this.regularPrice, this.salePrice, this.status, this.attributes,this.dateOnSaleFrom,this.dateOnSaleTo,this.description,this.images});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['stock_status'] = this.status;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationAttributeData {
  String? option;
  int? id;
  String? name;
  String? selectedValue;
  int? selectedId;

  VariationAttributeData({
    this.option,
    this.id,
    this.name,
    this.selectedValue = "",
    this.selectedId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['option'] = this.option;
    return data;
  }
}
