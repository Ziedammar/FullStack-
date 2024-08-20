import 'dart:convert';

import 'package:get/get.dart';

import '../Model/Commande_Model.dart';
import 'package:http/http.dart' as http;

class CommandeController extends GetxController{
  List<Commande> commande = [];



  static String apiUrl ="http://10.0.2.2:8000/";
  static  Future<void> postCommande(Commande commande) async {
    final response = await http.post(
      Uri.parse(apiUrl + 'api/ajoutercmd'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(commande.toJson()),
    );
    if (response.statusCode == 200) {
      print('Articles posted successfully.');

    } else {
      print(response.statusCode);
      throw Exception('error to create commande');
    }
  }
  Future<List<Commande>> getAllCmd() async {
    final response = await http.get(Uri.parse('${apiUrl}api/getcmd'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson =
      json.decode(utf8.decode(response.bodyBytes));

      commande = productJson.map((json) => Commande.fromJson(json)).toList();

      return commande;
    } else {
      throw Exception('Failed to load products');
    }
  }


}