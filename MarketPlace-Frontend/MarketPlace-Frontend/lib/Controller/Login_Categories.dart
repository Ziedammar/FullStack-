import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{

  Future<Map<String, dynamic>> postLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/auth/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      print(token);
      return {
        'success': true,
        'token': responseBody['token'],
      };
    } else {
      print(response.statusCode );
      final responseBody = jsonDecode(response.body);
      return {
        'success': false,
        'message': responseBody['message'],
      };
    }
  }
}