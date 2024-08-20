import 'dart:convert';

import 'package:eshop/Controller/FavorisController.dart';
import 'package:eshop/Model/ModelDTO.dart';
import 'package:eshop/Model/favoris.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavorisHome extends StatelessWidget {
  int id=0 ;
   FavorisHome( this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/home');

        },icon:  const Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(255, 122, 51, 10),
        ),),
        title: const Text(
          'Liste des favoris',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(255, 122, 51, 10),
          ),

        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(
            Icons.shopping_cart_checkout,
            color: Color.fromRGBO(255, 122, 51, 10),
          ),)
        ],
      ) ,
      body: GetBuilder<FavorisController>(
          init: FavorisController(),
          builder: (value)  {



            return FutureBuilder<List<ArticleDTO>>(
              future:  value.getAllProductFavoris(id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);

                  return const Text('error');
                } else if (snapshot.hasData) {
                  final ProduitFavoris = snapshot.data!;
                  return  ListView.builder(
                      itemCount: ProduitFavoris.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10,vertical: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1.2,
                                    blurRadius: 2,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                                                             ) ,
                              child:  ListTile(

                                title:Row(
                                  children: [
                                    Image.memory(base64Decode(ProduitFavoris[index].url.toString()),width: 180 ,height: 180,),
                                    const SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [

                                          Text(ProduitFavoris[index].name),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,))
                                        ],),
                                    SizedBox(width: 8,),
                                      Text('Prix TTC : ${ProduitFavoris[index].prix},000')
                                    ],),
                                  ],
                                ) ,

                              )
                          ),
                        );
                      });



                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }),


    );
  }
}
