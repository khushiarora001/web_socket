import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/models/event_model.dart';
import 'package:web_socket_assetment/utils/api_utils/api_exception.dart';
import 'package:web_socket_assetment/utils/api_utils/api_status.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

import '../utils/api_utils/comman_response.dart';

class EventRepository {
  EventRepository();

  // Method to fetch events
  Future<CommonResponse> fetchEvents() async {
    try {
      final response = await APIUtils.getEvents(eventsPath);

      EventsList resp = EventsList.fromJson(response);

      if (resp.events.isNotEmpty) {
        return CommonResponse(
          status: true,
          data: resp.events,
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
