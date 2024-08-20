import 'dart:convert';

import 'package:eshop/Model/User_Model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/UserConectModel.dart';
import '../Model/UserPost_Model.dart';

class UserController extends GetxController {
  static String apiUrlGet = "http://10.0.2.2:8000/";
  List<User> users = [];
  static String userscon ='' ;
  static String Role='';

  Future<List<User>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print(token);
    final response = await http.get(
      Uri.parse(apiUrlGet + "api/auth/users"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> userJson =
          json.decode(utf8.decode(response.bodyBytes));
      users = userJson.map((json) => User.fromJson(json)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
   Future<String> getContUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print(token);
    final response = await http.get(
      Uri.parse("${apiUrlGet}api/auth/user-profile"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
       Role = userJson['etat'];
      userscon = userJson['name'];
      print(Role);
      print('user connecter ${userscon}');
      final id = userJson['id'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('User_Id', id.toString());

      return Role;
    } else {
      throw Exception('Failed to load users Connected');
    }
  }

  Future<http.Response> LogOut() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt_token');
    final response = await http.post(
      Uri.parse(apiUrlGet + "api/auth/logout"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      await prefs.remove('jwt_token');
      print('Token removed');
      return response;
    } else {
      print('Logout failed with status code: ${response.statusCode}');
      throw Exception('Failed to logout');
    }
  }

  Future<http.Response> postUser(
    UserPost user,
  ) async {
    final response = await http.post(
      Uri.parse(apiUrlGet + 'api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return response;
    } else {
      print(response.statusCode);
      throw Exception('Failed to create client');
    }
  }
}
