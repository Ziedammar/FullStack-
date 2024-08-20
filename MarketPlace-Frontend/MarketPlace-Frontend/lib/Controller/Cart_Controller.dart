
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Commande_Model.dart';
import '../Model/ModelDTO.dart';
import '../Model/Product_Model.dart';
import '../screen/Auth/FournisseurPage.dart';
import 'Commande_Controller.dart';
import 'User_Controller.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  String x = "0";
  late int Sum;
  var listproduct= {}.obs ;
  late Commande dataCmd ;

 var prefs ;
  var token ;

  void AddProducts(ArticleDTO product) {
    if (listproduct.containsKey(product)){
      listproduct[product] +=1 ;
    }else{
      listproduct[product] =1;
    }
    Get.snackbar("Produit Ajoutée", "vous avez ajoutez le produit de marque ${product.name} au panier",
    snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1)
    );


  }
  RxMap get  data => listproduct ;

  void removeProduct(ArticleDTO  product) {
    if (listproduct.containsKey(product) &&listproduct [product] == 1) {
      listproduct.removeWhere((key, value) => key == product);
    } else {
      listproduct [product] -= 1;
    }
  }
  void removeAllProduct(ArticleDTO product) {
    listproduct.removeWhere((key, value) => key == product);

  }
  Future<void> lengthData() async {
    x = data.length.toString();
    print("print:$x");
    update();

  }


  get productSubtotal => listproduct.entries
      .map((product) => product.key.prix * product.value)
      .toList();
  get total  => listproduct.entries
      .map((product) => product.key.prix * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(3).toString();
  get ListQte  => listproduct.entries
      .map((product) => product.value)
      .toList().toString();
  get ListArt  => listproduct.entries
      .map((product) => product.key.name)
      .toList().toString();
  Future<void> DialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Cliquer sur ok pour confirmer cette commande!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Anuuler'),
            ),
            TextButton(
              onPressed: () async =>
              {
               prefs = await SharedPreferences.getInstance(),
               token = prefs.getString('jwt_token'),
              await UserController().getContUser(),



              dataCmd = Commande(id: 0,
                    user: UserController.userscon,
                    article: ListArt,
                    qte:ListQte ,
                    prix: double.parse(total).toInt(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now() ) ,
                await CommandeController.postCommande(dataCmd),


              },
              child: const Text('Commander'),
            ),

          ],
        );
      },
    );
  }
  Future<void> DialogBuilderD(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Opps Erreur'),
          content: Text("Il Faut Connecter pour passer une commande "),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Autre fois'),
            ),
            TextButton(
              onPressed: () =>Get.to(() => FournisseurPage()),
              child: const Text('Connecter'),
            ),

          ],
        );
      },
    );
  }
}