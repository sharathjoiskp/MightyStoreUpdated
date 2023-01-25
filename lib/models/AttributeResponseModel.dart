class AttributeResponseModel {
  int? id;
  String? name;
  String? slug;
  String? type;
  bool isSelected = false;

  AttributeResponseModel({this.id, this.name, this.slug, this.type});

  factory AttributeResponseModel.fromJson(Map<String, dynamic> json) {
    return AttributeResponseModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;

    data['slug'] = this.slug;
    data['type'] = this.type;

    return data;
  }
}
