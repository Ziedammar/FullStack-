import 'dart:convert';
import 'package:eshop/Controller/Cart_Controller.dart';
import 'package:eshop/Controller/ImageController.dart';
import 'package:eshop/Controller/User_Controller.dart';
import 'package:eshop/Model/Image_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_card/image_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/ControllerFavoris.dart';
import '../Model/favoris.dart';
import 'GetImage.dart';

Widget CardView(
  BuildContext context,
  int index,
  CartController cartController,
  categoriesController,
  product,
) {
  return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.2, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1.5,
            blurRadius: 3,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: FillImageCard(
          width: 250,
          heightImage: 230,
          imageProvider: MemoryImage(
            base64Decode(product[index].url.toString()),
          ),
          tags: [
            _tag("${product[index].prix!.toString()} TTC", () {}),
            _tag(product[index].categories!, () {}),
            _tage(() async {
              cartController.AddProducts(product[index]);
              await CartController().lengthData();
            }),
            _tage3(() async {
              await UserController().getContUser();
              final prefs = await SharedPreferences.getInstance();
              final id = prefs.getString('User_Id');
              final id_product = product[index].id;
              Favoris data;
              data = Favoris(userid: int.parse(id!), articleid: id_product);
              await ControllerFavoris.postArtFavoris(data);
              Get.snackbar("Produit Ajoutée à la liste des favoris","",
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 1));
            }),
          ],
          title: _title(product[index].name!),
          description: _content(product[index].description!),
        ),
      ));
}

Widget _title(String tag, {Color? color}) {
  return Text(
    tag,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
  );
}

Widget _content(String tag, {Color? color}) {
  return Text(
    tag,
    style: TextStyle(color: color),
  );
}

Widget _tag(String tag, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.orange.shade700),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget _tage(VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.orange.shade700),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: const Icon(
        Icons.add_shopping_cart,
        size: 18,
        color: Colors.white,
      ),
    ),
  );
}

Widget _tage3(VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.orange.shade700),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: const Icon(
        Icons.favorite_border,
        size: 18,
        color: Colors.white,
      ),
    ),
  );
}
