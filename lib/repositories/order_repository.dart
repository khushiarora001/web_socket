import 'dart:developer';

import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/models/order_book_response_model.dart';
import 'package:web_socket_assetment/utils/api_utils/api_exception.dart';
import 'package:web_socket_assetment/utils/api_utils/api_status.dart';

import 'package:web_socket_assetment/utils/api_utils/comman_response.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

class OrderRepository {
  OrderRepository();

  Future<CommonResponse> placeOrder(
      String eventId, String type, int quantity, num price) async {
    var body = {
      "eventId": eventId,
      "type": type,
      "quantity": quantity,
      "price": price,
    };
    try {
      final response = await APIUtils.postRequest(createOrderPath, body);

      Order resp = Order.fromJson(response);

      if (resp.id.isNotEmpty) {
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
          message: "Failed to fetch ,please try again ",
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
