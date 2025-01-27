import 'package:web_socket_assetment/constant/api_constant.dart';

import 'package:web_socket_assetment/utils/api_utils/comman_response.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

class OrderRepository {
  OrderRepository();

  Future<CommonResponse> placeOrder(
      String eventId, String type, int quantity, double price) async {
    var body = {
      "eventId": eventId,
      "type": type,
      "quantity": quantity,
      "price": price,
    };

    final response = await APIUtils.postRequest(createOrderPath, body);
    return CommonResponse.fromJson(response);
  }
}
