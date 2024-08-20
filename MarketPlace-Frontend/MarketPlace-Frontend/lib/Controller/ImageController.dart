import 'dart:convert';

import 'package:eshop/Model/Image_Model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController{
  String apiUrlGet="http://10.0.2.2:8000/";
  List<String> ImageEncode=[];
  Future<List<ImageModel>> getImage(int Imageid) async {
    final response =  await http.get(Uri.parse('${apiUrlGet}api/images/${Imageid}'));
    if (response.statusCode == 200) {
      final List<dynamic> ImageJson =
      json.decode(utf8.decode(response.bodyBytes));

      final Image =
      ImageJson.map((json) => ImageModel.fromJson(json)).toList();
      ImageEncode.add(Image[0].url!);
      return Image;
    } else {
      throw Exception('Failed to load image');
    }
  }
}