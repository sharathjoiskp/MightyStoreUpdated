import 'BillingModel.dart';
import 'ShippingModel.dart';

class LoginResponse {
    String? avatar;
    Billing? billing;
    String? firstName;
    String? lastName;
    String? profileImage;
    Shipping? shipping;
    String? token;
    String? userDisplayName;
    String? userEmail;
    int? userId;
    String? userNiceName;
    List<String>? userRole;

    LoginResponse({this.avatar, this.billing, this.firstName, this.lastName, this.profileImage, this.shipping, this.token, this.userDisplayName, this.userEmail, this.userId, this.userNiceName, this.userRole});

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
        return LoginResponse(
            avatar: json['avatar'], 
            billing: json['billing'] != null ? Billing.fromJson(json['billing']) : null, 
            firstName: json['first_name'], 
            lastName: json['last_name'], 
            profileImage: json['profile_image'], 
            shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null, 
            token: json['token'], 
            userDisplayName: json['user_display_name'], 
            userEmail: json['user_email'], 
            userId: json['user_id'], 
            userNiceName: json['user_nicename'], 
            userRole: json['user_role'] != null ? new List<String>.from(json['user_role']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar'] = this.avatar;
        data['first_name'] = this.firstName;
        data['last_name'] = this.lastName;
        data['profile_image'] = this.profileImage;
        data['token'] = this.token;
        data['user_display_name'] = this.userDisplayName;
        data['user_email'] = this.userEmail;
        data['user_id'] = this.userId;
        data['user_nicename'] = this.userNiceName;
        if (this.billing != null) {
            data['billing'] = this.billing!.toJson();
        }
        if (this.shipping != null) {
            data['shipping'] = this.shipping!.toJson();
        }
        if (this.userRole != null) {
            data['user_role'] = this.userRole;
        }
        return data;
    }
}


