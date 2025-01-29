class VerifyotpModel {
  String? message;
  String? token;
  int? loginCount;

  VerifyotpModel({this.message, this.token, this.loginCount});

  VerifyotpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    loginCount = json['loginCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['loginCount'] = this.loginCount;
    return data;
  }
}
