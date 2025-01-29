// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/utils/api_utils/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui_utils/helper.dart';

///[APIUtils] class to provide utility for HTTP methods like get, post, patch, etc.
class APIUtils {
  // Private constructor for Singleton pattern
  APIUtils._privateConstructor();

  // Single instance of APIUtils

  ///[getRequest] method to use get API call to server.
  ///param : [apiUrl] -> API URL
  ///param : [headers] -> API headers for the [apiUrl]
  static Future<Map<String, dynamic>> getRequest(
    String apiUrl,
  ) async {
    try {
      //Remote Call to API with url and headers
      http.Response apiResponse = await http.get(
        await _apiPath(apiUrl, "GET"),
      );

      //Checking for the response code and handling the result.
      return _returnResponse(apiResponse);
    }

    //Handling the condition when socket exception received.
    on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  ///[postRequest] function for GET requests with auth token as header
  ///and request type as form data.
  ///param : [apiUrl] -> API URL
  static Future<Map<String, dynamic>> postRequest(
      String apiUrl, dynamic requestBody,
      {bool enableHeader = true}) async {
    try {
      Helper.printJSONData(requestBody);

      //Getting response from api call
      http.Response apiResponse = await http.post(
          await _apiPath(apiUrl, "POST WITH HEADER"),
          body: jsonEncode(requestBody),
          headers: enableHeader ? await _headers() : {});
      //Checking for the response code and handling the result.
      return _returnResponse(apiResponse);
    }

    //Handling the condition when socket exception received.
    on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  Future<Map<String, dynamic>> putRequest(String apiUrl, dynamic requestBody,
      {bool enableHeader = true}) async {
    try {
      log(requestBody);

      //Getting response from api call
      http.Response apiResponse = await http.put(await _apiPath(apiUrl, "PUT"),
          body: jsonEncode(requestBody),
          headers: enableHeader ? await _headers() : {});
      log(apiResponse.toString());
      //Checking for the response code and handling the result.
      return _returnResponse(apiResponse);
    }

    //Handling the condition when socket exception received.
    on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  Future<Map<String, dynamic>> getRequestWithHeaders(String apiUrl) async {
    try {
      //Remote Call to API with url and headers
      http.Response apiResponse = await http.get(
          await _apiPath(apiUrl, "GET WITH HEADER"),
          headers: await _headers());

      //Checking for the response code and handling the result.
      return _returnResponse(apiResponse);
    } on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  static Future<Map<String, dynamic>> getRequestWithCompleteUrl(
      String apiUrl) async {
    try {
      //Remote Call to API with url and headers
      http.Response apiResponse = await http.get(Uri.parse(apiUrl));

      //Checking for the response code and handling the result.
      return _returnResponse(apiResponse);
    }

    //Handling the condition when socket exception received.
    on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  static Future<Map<String, dynamic>> postRequestWithoutHeaders(
      String apiUrl, dynamic body) async {
    try {
      //Remote Call to API with url and headers
      http.Response apiResponse = await http.post(
          await _apiPath(apiUrl, "POST"),
          body: jsonEncode(body),
          headers: headers);
      //  .timeout(Duration(seconds: 15),
      //  onTimeout: () {
      //    throw FetchDataException(FAILURE_OCCURED);
      //  });
      log(apiResponse.body.toString());
      //Checking for the response code and handling the result.
      return _returnResponse(apiResponse);
    }

    //Handling the condition when socket exception received.
    on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  static var headers = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
  };
  static Future<Uri> _apiPath(String url, String method) async {
    //Parsing the apiURl to Uri

    Uri uri = Uri.parse(baseUrl + url);
    log('$method API :: $uri');
    return uri;
  }

  static Future<Map<String, String>> _headers() async {
    //Getting auth token
    String authToken = await getToken();
    log("TOKEN: $authToken");
    //Creating http headers for api
    Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
    return headers;
  }

  static Future<List<dynamic>> getEvents(
    String apiUrl,
  ) async {
    try {
      // Remote Call to API with URL
      http.Response apiResponse = await http.get(
        await _apiPath(apiUrl, "GET"),
      );
      log(apiResponse.toString());
      // Checking the response code and handling the result
      return _returnResponse(apiResponse);

      // Assuming the API response has a key "data" that contains the list of events
    } on SocketException {
      throw FetchDataException("Failure Occured");
    }
  }

  // Handling the condition when a socket exception occurs

  ///Function to handle the response as per status code from api server
  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        // Helper.printJSONData(responseJson);
        return responseJson;

      case 201:
        var responseJson = jsonDecode(response.body);
        // Helper.printJSONData(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnAuthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException("Server exception : ${response.statusCode}");
    }
  }

  ///Function for building the auth token to be used in api headers
  ///using API Key and API Secret.
  static Future<String> getToken() async {
    //Creating object for DBPreferences

    //Getting API Key
    final prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    //Returning the final auth token as result
    return "$token";
  }

  static Future<dynamic> postMultipartRequest(
      String url, String filePath, String fileName) async {
    var uri = Uri.parse(url);
    try {
      print(url);

      print(filePath);
      var request = http.MultipartRequest('POST', uri);

      File file = File(filePath);
      request.files.add(http.MultipartFile(
          "image", file.readAsBytes().asStream(), file.lengthSync(),
          filename: fileName));

      // filename: file.path.split('/').last));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map<String, dynamic> map =
            jsonDecode(await response.stream.bytesToString());
        return map;
      }

      return Exception("File not uploaded successfully");
    } catch (e) {
      print(e.toString());
      // Handing Exception
      throw FetchDataException("Failure Occured");
    }
  }
}
