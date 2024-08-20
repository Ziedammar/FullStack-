import 'dart:convert';
import 'package:eshop/Controller/Cart_Controller.dart';
import 'package:eshop/Controller/ImageController.dart';
import 'package:eshop/Model/Image_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:provider/provider.dart';

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
      child:  Stack(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.2, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1.5,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: Image.memory(
                        base64Decode(product[index].url.toString()),
                        width: 150,
                        height: 150,
                      ),),

                      Flexible(child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 140,
                        height: 50,
                        child: categoriesController.marq
                            .contains((product[index].name!).toLowerCase())
                            ? Image.asset(
                          'assets/images/${(product[index].name!).toLowerCase()}.png',
                        )
                            : null,
                      ),),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${product[index].prix!} DT TTC',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Flexible(child: Row(
                        children: [
                          GetBuilder<CartController>(
                              init: CartController(),
                              builder: (value) {
                                return Flexible(child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    border: Border.all(width: 0, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                        cartController.AddProducts(product[index]);
                                        value.lengthData();
                                    },
                                    icon: Icon(Icons.shopping_cart_outlined),
                                  ),
                                ));
                              }),
                          Flexible(child: Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(width: 0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove_red_eye_outlined),
                            ),
                          )),
                          Flexible(child: Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(width: 0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border_rounded),
                            ),
                          ),)
                        ],
                      ),)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: Text(
                            product[index].name!,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(255, 122, 51, 10),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(product[index].categories!),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.36,
                            child: Text(product[index].description!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          )
        ],
      )
  );
}