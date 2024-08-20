import 'package:eshop/View/Cart_Total.dart';
import 'package:eshop/screen/CartPage/cartPage.dart';
import 'package:eshop/screen/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/User_Controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.sort , color: Color.fromRGBO(255, 122, 51, 10),),
          title: const Text('Votre Panier',style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(255, 122, 51, 10),
          ),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back ,color: Color.fromRGBO(255, 122, 51, 10),),
              onPressed: () {
                Get.to(()=> HomePage());
              },
            ),
            IconButton(onPressed: () async {
              await UserController().LogOut();
              Navigator.of(context).pop();
              Navigator.pushNamed(context,'/home');

            }, icon: Icon(Icons.logout,color: Color.fromRGBO(255, 122, 51, 10),))

          ],
        ),
        body: Container(
            child: Column(
              children: [
                Container(child: CartPage(),),

                Flexible(

                  child: CartTotal(),),


              ],


            )
        )
    );
  }
}
