import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';

import 'package:eshop/Controller/Categories_Controller.dart';
import 'package:eshop/Model/favoris.dart';
import 'package:eshop/screen/CartPage/Cart_Screen.dart';
import 'package:eshop/screen/Auth/FournisseurPage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/Cart_Controller.dart';
import '../../Controller/Product_Controller.dart';

import '../../Controller/User_Controller.dart';

import '../Favoris/FavorisHome.dart';
import 'AllProduct.dart';

class HomePage extends GetView<ProductController> {
  final cartController = Get.put(CartController());
  final categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.sort,
            color: Color.fromRGBO(255, 122, 51, 10),
          ),
          title: const Text(
            'AC Market',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(255, 122, 51, 10),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.login_outlined,
                color: Color.fromRGBO(255, 122, 51, 10),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('jwt_token');
                print('this is token :  ${token}');
                if (token == null) {
                  Get.to(() => FournisseurPage());
                } else {
                  await UserController().getContUser();
                  if (UserController.Role == "Admin") {Navigator.pop(context);
                  Navigator.pushNamed(context, '/EspaceFr');}
                  else {
                    Get.to(() => const CartScreen());


                  }
                }
              },
            ),
            IconButton(onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final id = prefs.getString('User_Id');

              Get.to(() =>  FavorisHome(int.parse(id!)));

            }, icon: const Icon(Icons.favorite_outline_sharp ,color:Color.fromRGBO(255, 122, 51, 10) ,)),

            GetBuilder<CartController>(
                init: CartController(),
                builder: (value) {
                  return Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: badges.Badge(
                      position: BadgePosition.topEnd(top: 0),
                      badgeContent: Text(
                        value.x,
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const CartScreen());
                        },
                        icon: const Icon(
                          Icons.shopping_cart_checkout,
                          color: Color.fromRGBO(255, 122, 51, 10),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
        body:Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 3),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.69,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here...",
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo,
                          color: Color.fromRGBO(255, 122, 51, 10),
                        ))
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical:2,
                  horizontal: 10,
                ), // Edge Insets.symmetric
                child: const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 122, 51, 10),
                  ),
                ), // Text
              ),
              GetBuilder<CategoriesController>(
                  init: CategoriesController(),
                  builder: (value) {
                    return SizedBox(
                        height: 70,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                          const VerticalDivider(
                            color: Colors.transparent,
                            width: 5,
                          ),
                          itemCount: value.images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                value.selectedMenuItem = index;
                                value.categ();
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, '/home');
                              },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 5),
                                      padding: const EdgeInsets.all(10),
                                      width: (value.descL[index].length * 7) +
                                          100,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.2, color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1.2,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                5), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/images/${value.images[index]}",
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 6),
                                            child: Text(
                                              value.descL[index],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
                  }),
              GetBuilder<CategoriesController>(
                  init: CategoriesController(),
                  builder: (value) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ), // Edge Insets.symmetric
                      child: Text(
                        value.desc,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 122, 51, 10),
                        ),
                      ),
                    );
                  }),
              GetBuilder<CategoriesController>(
                  init: CategoriesController(),
                  builder: (value) {
                    return Flexible(
                      child: AllProduct( value.desc),
                    );
                  }),

            ],
          ),
        )
          );
  }
}
