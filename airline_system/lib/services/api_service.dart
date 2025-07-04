import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/auth_helper.dart';
import '../models/flight_model.dart';
import '../models/seat_model.dart';
import '../models/user_model.dart';

class ApiService {
  // User Authentication
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await AuthHelper.saveToken(data['token']);
      await AuthHelper.saveRole(data['role']);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> register(
      String name, String email, String password,String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email,'password': password,'role':role}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  // Fetch Flights
  static Future<List<Flight>> fetchFlights() async {
    final response = await http.get(Uri.parse('$flightsEndpoint'));
    
    if (response.statusCode == 200) {
      List<dynamic> flightsJson = jsonDecode(response.body);
      return flightsJson.map((json) => Flight.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load flights');
    }
  }

  // Book a Seat
  static Future<Map<String, dynamic>> bookSeat(
      String flightId, String seatNumber) async {
    final token = await AuthHelper.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/seats/book'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'flightId': flightId, 'seatNumber': seatNumber}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to book seat');
    }
  }

  static Future<List<dynamic>> getSeats(String flightId) async {
    final url = Uri.parse('$baseUrl/seats/$flightId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Convert JSON response to a list
      } else {
        throw Exception('Failed to load seats');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Officer: Add Flight
  static Future<Map<String, dynamic>> addFlight(
      Map<String, dynamic> flightData) async {
    final token = await AuthHelper.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/flights'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(flightData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add flight');
    }
  }

  // Officer: Update Flight
  static Future<Map<String, dynamic>> updateFlight(
      String flightId, Map<String, dynamic> flightData) async {
    final token = await AuthHelper.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/flights/$flightId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(flightData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update flight');
    }
  }

  // Officer: Delete Flight
  static Future<Map<String, dynamic>> deleteFlight(String flightId) async {
    final token = await AuthHelper.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/flights/$flightId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete flight');
    }
  }
}
