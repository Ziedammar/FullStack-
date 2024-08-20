import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../Model/ModelDTO.dart';
import '../Model/Product_Model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController, addressController;

  String apiUrlGet = "http://10.0.2.2:8000/";
  List<ArticleDTO> products = [];

  Future<List<ArticleDTO>> getAllProduct() async {
    final response = await http.get(Uri.parse('${apiUrlGet}api/articless'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson =
          json.decode(utf8.decode(response.bodyBytes));

      products =
          productJson.map((json) => ArticleDTO.fromJson(json)).toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<ArticleDTO>> getAllProductbycat(String cat ) async {
    final response = await http.get(Uri.parse('${apiUrlGet}api/articles/$cat'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson =
      json.decode(utf8.decode(response.bodyBytes));

      products =
          productJson.map((json) => ArticleDTO.fromJson(json)).toList();
      update();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    addressController.clear();
  }
}
