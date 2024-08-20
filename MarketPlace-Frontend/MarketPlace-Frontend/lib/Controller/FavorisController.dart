import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../Model/ModelDTO.dart';
import '../Model/Product_Model.dart';

class FavorisController extends GetxController {
  static FavorisController instance = Get.find();

  String apiUrlGet = "http://10.0.2.2:8000/";
  List<ArticleDTO> productsfavoris = [];

  Future<List<ArticleDTO>> getAllProductFavoris(int id) async {
    final response = await http.get(Uri.parse('${apiUrlGet}api/articles/user/$id/favorites'));

    if (response.statusCode == 200) {
      final List<dynamic> productfavorisJson =
      json.decode(utf8.decode(response.bodyBytes));

      productsfavoris =
          productfavorisJson.map((json) => ArticleDTO.fromJson(json)).toList();

      return productsfavoris;
    } else {
      throw Exception('Failed to load products');
    }
  }


}
