import 'AttributeModel.dart';

class UpdateReviewResponse {
  String? dateCreated;
  String? dateCreatedGmt;
  int? id;
  Links? links;
  int? productId;
  int? rating;
  String? review;
  String? reviewer;
  ReviewerAvatarUrls? reviewerAvatarUrls;
  String? reviewerEmail;
  String? status;
  bool? verified;

  UpdateReviewResponse({this.dateCreated, this.dateCreatedGmt, this.id, this.links, this.productId, this.rating, this.review, this.reviewer, this.reviewerAvatarUrls, this.reviewerEmail, this.status, this.verified});

  factory UpdateReviewResponse.fromJson(Map<String, dynamic> json) {
    return UpdateReviewResponse(
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      id: json['id'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      productId: json['product_id'],
      rating: json['rating'],
      review: json['review'],
      reviewer: json['reviewer'],
      reviewerAvatarUrls: json['reviewer_avatar_urls'] != null ? ReviewerAvatarUrls.fromJson(json['reviewer_avatar_urls']) : null,
      reviewerEmail: json['reviewer_email'],
      status: json['status'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['reviewer'] = this.reviewer;
    data['reviewer_email'] = this.reviewerEmail;
    data['status'] = this.status;
    data['verified'] = this.verified;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.reviewerAvatarUrls != null) {
      data['reviewer_avatar_urls'] = this.reviewerAvatarUrls!.toJson();
    }
    return data;
  }
}


class Up {
  String? href;

  Up({this.href});

  factory Up.fromJson(Map<String, dynamic> json) {
    return Up(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class ReviewerAvatarUrls {
  String? twentyFour;
  String? fourtyEight;
  String? ninetySix;

  ReviewerAvatarUrls({this.twentyFour, this.fourtyEight, this.ninetySix});

  factory ReviewerAvatarUrls.fromJson(Map<String, dynamic> json) {
    return ReviewerAvatarUrls(
      twentyFour: json['24'],
      fourtyEight: json['48'],
      ninetySix: json['96'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['24'] = this.twentyFour;
    data['48'] = this.fourtyEight;
    data['96'] = this.ninetySix;
    return data;
  }
}