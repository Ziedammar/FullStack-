import 'dart:convert';
import 'dart:io';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Model/Product_Model.dart';

class addProduceController extends GetxController{
  String? fileName;
  UploadTask? uploadTask;
  static String apiUrlPoste ='http://192.168.1.13:8000/api/Article';


  final TextEditingController nameProductTextEditingController =
  TextEditingController();
  final TextEditingController descTextEditingController =
  TextEditingController();
  final TextEditingController catTextEditingController =
  TextEditingController();
  final TextEditingController prixTextEditingController =
  TextEditingController();
  TextEditingController nameContr =
  TextEditingController();

  String imgRef='';

  File? image = null;
  final picker = ImagePicker();
  @override
  void dispose() {
    super.dispose();
    nameProductTextEditingController.dispose();
    descTextEditingController.dispose();
    catTextEditingController.dispose();
    prixTextEditingController.dispose();
  }

  final List<SelectedListItem> listOfCities = [
    SelectedListItem(name: "Ordinateur Portable",),
    SelectedListItem(name: "Climatiseur",),
    SelectedListItem(name: "Imprimente",),
    SelectedListItem(name: "OrdinateurFix"),
    SelectedListItem(name: "Telephone"),
    SelectedListItem(name: "frigidaire"),
    SelectedListItem(name: "machine a laver"),
    SelectedListItem(name: "machine a vaisselle"),
    SelectedListItem(name: "bisiklet"),
    SelectedListItem(name: "plaque chauffante"),
    SelectedListItem(name: "vetement homme"),
    SelectedListItem(name: "vetement femme"),];
  static Future<Product> postProduit(Product productModel, ) async {
    final response = await http.post(Uri.parse(apiUrlPoste),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productModel.toJson()),
    );
    if (response.statusCode == 200) {
      return  Product.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(response.statusCode);
      throw Exception('Failed to create client');
    }

  }

  Future saveProrduct() async {
    final produce = Product(
      description:descTextEditingController.text,
      prix:int.tryParse(prixTextEditingController.text),
      marque:nameProductTextEditingController.text ,
      categories: catTextEditingController.text,
      id_Image: null,

    );
    print('${descTextEditingController.text}///${prixTextEditingController.text}///${nameProductTextEditingController.text}//${catTextEditingController.text}');
    postProduit(produce);


  }



  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      update();

  }

}