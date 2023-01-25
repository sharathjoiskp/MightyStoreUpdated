class DeleteCustomerResponse {
    String? avatarUrl;
    Billing? billing;
    String? dateCreated;
    String? dateCreatedGmt;
    String? dateModified;
    String? dateModifiedGmt;
    String? email;
    String? firstName;
    int? id;
    bool? isPayingCustomer;
    String? lastName;
    Links? links;
    String? role;
    Shipping? shipping;
    String? username;

    DeleteCustomerResponse({this.avatarUrl, this.billing, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.email, this.firstName, this.id, this.isPayingCustomer, this.lastName, this.links, this.role, this.shipping, this.username});

    factory DeleteCustomerResponse.fromJson(Map<String, dynamic> json) {
        return DeleteCustomerResponse(
            avatarUrl: json['avatar_url'],
            billing: json['billing'] != null ? Billing.fromJson(json['billing']) : null,
            dateCreated: json['date_created'],
            dateCreatedGmt: json['date_created_gmt'],
            dateModified: json['date_modified'],
            dateModifiedGmt: json['date_modified_gmt'],
            email: json['email'],
            firstName: json['first_name'],
            id: json['id'],
            isPayingCustomer: json['is_paying_customer'],
            lastName: json['last_name'],
            links: json['links'] != null ? Links.fromJson(json['links']) : null,
            role: json['role'],
            shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar_url'] = this.avatarUrl;
        data['date_created'] = this.dateCreated;
        data['date_created_gmt'] = this.dateCreatedGmt;
        data['date_modified'] = this.dateModified;
        data['date_modified_gmt'] = this.dateModifiedGmt;
        data['email'] = this.email;
        data['first_name'] = this.firstName;
        data['id'] = this.id;
        data['is_paying_customer'] = this.isPayingCustomer;
        data['last_name'] = this.lastName;
        data['role'] = this.role;
        data['username'] = this.username;
        if (this.billing != null) {
            data['billing'] = this.billing!.toJson();
        }
        if (this.links != null) {
            data['links'] = this.links!.toJson();
        }
        if (this.shipping != null) {
            data['shipping'] = this.shipping!.toJson();
        }
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