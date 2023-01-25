class AttributeModel {
    Links? links;
    bool? hasArchives;
    int? id;
    String? name;
    String? orderBy;
    String? slug;
    String? type;

    AttributeModel({this.links, this.hasArchives, this.id, this.name, this.orderBy, this.slug, this.type});

    factory AttributeModel.fromJson(Map<String, dynamic> json) {
        return AttributeModel(
            links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
            hasArchives: json['has_archives'],
            id: json['id'],
            name: json['name'],
            orderBy: json['order_by'],
            slug: json['slug'],
            type: json['type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['has_archives'] = this.hasArchives;
        data['id'] = this.id;
        data['name'] = this.name;
        data['order_by'] = this.orderBy;
        data['slug'] = this.slug;
        data['type'] = this.type;
        if (this.links != null) {
            data['_links'] = this.links!.toJson();
        }
        return data;
    }
}

class Links {
    List<Collection>? collection;
    List<Self>? self;

    Links({this.collection, this.self});

    factory Links.fromJson(Map<String, dynamic> json) {
        return Links(
            collection: json['collection'] != null ? (json['collection'] as List).map((i) => Collection.fromJson(i)).toList() : null,
            self: json['self'] != null ? (json['self'] as List).map((i) => Self.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.collection != null) {
            data['collection'] = this.collection!.map((v) => v.toJson()).toList();
        }
        if (this.self != null) {
            data['self'] = this.self!.map((v) => v.toJson()).toList();
        }
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