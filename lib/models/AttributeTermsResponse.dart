class AttributeTermsResponse {
  int? count;
  String? description;
  int? id;
  int? menuOrder;
  String? name;
  String? slug;

  AttributeTermsResponse(
      {this.count,
      this.description,
      this.id,
      this.menuOrder,
      this.name,
      this.slug});

  factory AttributeTermsResponse.fromJson(Map<String, dynamic> json) {
    return AttributeTermsResponse(
      count: json['count'],
      description: json['description'],
      id: json['id'],
      menuOrder: json['menu_order'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['description'] = this.description;
    data['id'] = this.id;
    data['menu_order'] = this.menuOrder;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
