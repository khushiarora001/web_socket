import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/models/event_model.dart';
import 'package:web_socket_assetment/utils/api_utils/api_status.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

import '../utils/api_utils/comman_response.dart';

class EventRepository {
  EventRepository();

  // Method to fetch events
  Future<CommonResponse> fetchEvents() async {
    final response = await APIUtils.getRequest(eventsPath);
    return CommonResponse.fromJson(response);
  }
}
