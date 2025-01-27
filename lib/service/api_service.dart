import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<dynamic>> fetchEvents() async {
    final url = Uri.parse('$baseUrl/events');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> placeOrder(String eventId) async {
    final url = Uri.parse('$baseUrl/placeOrder');
    final response = await http.post(
      url,
      body: json.encode({'eventId': eventId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to place order');
    }
  }
}
