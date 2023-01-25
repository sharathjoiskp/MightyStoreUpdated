class Shipping {
  String? address_1;
  String? address_2;
  String? city;
  String? company;
  String? country;
  String? firstName;
  String? lastName;
  String? postcode;
  String? state;

  Shipping({this.address_1, this.address_2, this.city, this.company, this.country, this.firstName, this.lastName, this.postcode, this.state});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      address_1: json['address_1'],
      address_2: json['address_2'],
      city: json['city'],
      company: json['company'],
      country: json['country'],
      firstName: json['first_name'],
      lastName: json['last_name'],
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
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    return data;
  }
}