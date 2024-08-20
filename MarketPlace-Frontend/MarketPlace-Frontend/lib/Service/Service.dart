import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class Service {
  Future<void> addImage(String filepath) async {
    try {
      // Encodez l'image en Uint8List
      Uint8List imageBytes = await File(filepath).readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String a ='${base64Image}';
      print(a);
      // Créez la requête http.MultipartRequest
      var request =
      http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:8000/api/uploadimage'));

      // Ajoutez l'image à la demande
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpg'),
      ));

      // Envoyez la requête en utilisant http.Client
      var response = await http.Client().send(request);

      // Gérez la réponse
      if (response.statusCode == 200) {
        // Traitement en cas de succès
      } else {
        // Traitement en cas d'erreur
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}