import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

import '../utils/api_utils/comman_response.dart';

class AuthRepository {
  Future<CommonResponse> sendOtp(String mobile) async {
    final response = await APIUtils.postRequestWithoutHeaders(
        sendOtpPath, {"mobile": mobile});
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> verifyOtp(
      String mobile, String sessionId, String otp) async {
    final response = await APIUtils.postRequestWithoutHeaders(
      verifyOtpPath,
      {"mobile": mobile, "sessionId": sessionId, "otp": otp},
    );
    return CommonResponse.fromJson(response);
  }
}
