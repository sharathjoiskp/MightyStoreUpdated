import 'AttributeModel.dart';

class ProductAttributeTermResponse {
    Links? links;
    int? count;
    String? description;
    int? id;
    int? menuOrder;
    String? name;
    String? slug;

    ProductAttributeTermResponse({this.links, this.count, this.description, this.id, this.menuOrder, this.name, this.slug});

    factory ProductAttributeTermResponse.fromJson(Map<String, dynamic> json) {
        return ProductAttributeTermResponse(
            links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
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
        if (this.links != null) {
            data['_links'] = this.links!.toJson();
        }
        return data;
    }
}
