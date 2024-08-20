import 'dart:convert';

import 'package:eshop/screen/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/Cart_Controller.dart';
import '../../Controller/ImageController.dart';
import '../../Model/Image_Model.dart';
import '../../Model/ModelDTO.dart';
import '../../Model/Product_Model.dart';
class CartPage extends StatelessWidget {
  final CartController controller = Get.find() ;

   CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.75,

      child:  Obx(
            () => ListView.builder(
            itemCount: controller.data.length,
            itemBuilder:(BuildContext context ,int index) {
              return CardProductCard(
                controller: controller,
                product: controller.data.keys.toList()[index],
                qte: controller.data.values.toList()[index],
                index: index,);
            }
        ),
      ),
    );
  }
}

class CardProductCard extends StatelessWidget {
  final CartController controller ;
  final ArticleDTO product ;
  final int qte ;
  final int index ;

  const CardProductCard({Key? key,
    required this.controller,
    required this.product,
    required this.qte,
    required this.index,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric (vertical: 10,horizontal: 15),
      padding: EdgeInsets.symmetric ( vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color:  Colors.white,
        border: Border.all(
            width: 0.2,
            color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1.2,
            blurRadius: 2,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GetBuilder<ImageController>(
              init: ImageController(),
              builder: (value) {
                int Imageid = product.image! ;


                return FutureBuilder<List<ImageModel>>(
                  future:  value.getImage(Imageid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);

                      return Text('error');
                    } else if (snapshot.hasData) {
                      final image = snapshot.data!;
                      return

                        Image.memory(base64Decode(image[0].url.toString()),width: 140 ,height: 140,);

                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.name.toString() , style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17
                  ),),
                  GetBuilder<CartController>(
                      init: CartController(),
                      builder: (value){
                        return  IconButton(onPressed: (){
                          controller.removeAllProduct(product);
                          value.lengthData();

                        }, icon: Icon(Icons.delete , color: Colors.red,))
                        ;
                      }),

                ],
              ),
            SizedBox(height: 5,),
            Text(product.name.toString().toUpperCase() , style: TextStyle(
              color: Colors.orange,
              fontSize: 16
            ),),
              SizedBox(height: 5,),
              Row(

                children: [
                  Text(product.prix.toString() , style: TextStyle(
                      color: Colors.black ,
                      fontSize: 16
                  ),),

                    IconButton(
                    onPressed: () {
                      controller.removeProduct(product);

                    },
                    icon: Icon (Icons.remove_circle),
                    ),
                    Text('${qte}'),
                    IconButton(
                    onPressed: () {
                      controller.AddProducts(product);

                    },
                    icon: Icon (Icons.add_circle),
                    ),

                ],
              ),


          ],)
        ],
      ),
    );
  }
}
