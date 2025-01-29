import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/models/verify_otp_model.dart';
import 'package:web_socket_assetment/utils/api_utils/api_exception.dart';
import 'package:web_socket_assetment/utils/api_utils/api_status.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

import '../utils/api_utils/comman_response.dart';

class AuthRepository {
  Future<CommonResponse> sendOtp(String mobile) async {
    try {
      // Prepare the request data
      final data = {"mobile": mobile};

      // Make the API request
      final response =
          await APIUtils.postRequestWithoutHeaders(sendOtpPath, data);

      // Debug log for API response

      log("API Response: $response");

      // Parse the response
      final message = response['message'];
      final sessionId = response['sessionId'];

      // Handle success response
      if (message != null && sessionId != null) {
        return CommonResponse(
          status: true,
          data: {
            "message": message,
            "sessionId": sessionId,
          },
          apiStatus: ApiStatus.REQUEST_SUCCESS,
          message: message,
        );
      } else {
        // Handle API failure response
        return CommonResponse(
          status: false,
          message: "Failed to send OTP. Please try again.",
          apiStatus: ApiStatus.REQUEST_FAILURE,
        );
      }
    } on ApiException catch (e) {
      // Handle API-specific exceptions
      log("API Exception: ${e}");
      return CommonResponse(
        status: false,
        message: "An error occurred: ${e}",
        apiStatus: ApiStatus.REQUEST_FAILURE,
      );
    } catch (e) {
      // Handle unexpected errors
      log("Unexpected error: $e");
      return CommonResponse(
        status: false,
        message: "Unexpected error occurred",
        apiStatus: ApiStatus.REQUEST_FAILURE,
      );
    }
  }

  Future<CommonResponse> verifyOtp(
      String mobile, String sessionId, String otp) async {
    try {
      final response = await APIUtils.postRequestWithoutHeaders(
        verifyOtpPath,
        {"mobile": mobile, "sessionId": sessionId, "otp": otp},
      );
      VerifyotpModel resp = VerifyotpModel.fromJson(response);
      if (resp.message == "OTP Verified, logged in successfully") {
        final prefs = await SharedPreferences.getInstance();
        var token = await prefs.setString('token', resp.token ?? "");
        return CommonResponse(
          status: true,
          data: resp,
          apiStatus: ApiStatus.REQUEST_SUCCESS,
          message: resp,
        );
      } else {
        // Handle API failure response
        return CommonResponse(
          status: false,
          message: "Failed to send OTP. Please try again.",
          apiStatus: ApiStatus.REQUEST_FAILURE,
        );
      }
    } on ApiException catch (e) {
      // Handle API-specific exceptions
      log("API Exception: ${e}");
      return CommonResponse(
        status: false,
        message: "An error occurred: ${e}",
        apiStatus: ApiStatus.REQUEST_FAILURE,
      );
    } catch (e) {
      // Handle unexpected errors
      log("Unexpected error: $e");
      return CommonResponse(
        status: false,
        message: "Unexpected error occurred",
        apiStatus: ApiStatus.REQUEST_FAILURE,
      );
    }
  }
}
