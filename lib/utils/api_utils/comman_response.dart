import 'api_status.dart';

///[CommonResponse] class to handle the basic response from api
class CommonResponse {
  bool? status;
  dynamic message;
  ApiStatus? apiStatus;
  dynamic data;
  //constructor
  CommonResponse(
      {this.status = true,
      this.message = 'success',
      this.apiStatus = ApiStatus.NONE,
      this.data});

  //create class object from json
  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    apiStatus = json['apiStatus'];
    data = json['data'];
  }

  // convert object to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['apiStatus'] = apiStatus;
    data['data'] = data;
    return data;
  }
}
