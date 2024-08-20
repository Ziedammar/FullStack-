import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Model/favoris.dart';

class ControllerFavoris extends GetxController{

  List<Favoris> favoris =[];

  static String apiUrl ="http://10.0.2.2:8000/";
  static  Future<void> postArtFavoris(Favoris favoris) async {
    final response = await http.post(
      Uri.parse(apiUrl + 'api/favorite'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(favoris.toJson()),
    );
    if (response.statusCode == 200) {
      print('Articles Favorite posted successfully .');

    } else {
      print(response.statusCode);
      throw Exception('error to create Articles Favorite');
    }
  }
  Future<List<Favoris>> getAllCmd() async {
    final response = await http.get(Uri.parse('${apiUrl}/api/favorite'));

    if (response.statusCode == 200) {
      final List<dynamic> favorisJson =
      json.decode(utf8.decode(response.bodyBytes));


      favoris = favorisJson.map((json) => Favoris.fromJson(json)).toList();

      return favoris;
    } else {
      throw Exception('Failed to load products');
    }
  }


}