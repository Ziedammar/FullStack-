import 'package:eshop/Controller/addproduceController.dart';
import 'package:eshop/Service/Service.dart';
import 'package:flutter/material.dart';

import '../screen/AddProduce/AppTextFiled.dart';
import 'BuildProgress.dart';

Widget mainBody(addProduceController addproduceController, Service service) => Padding(
  padding: const EdgeInsets.only(left: 20.0 , right: 20 ,top: 12.5),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10.0,
      ),
      Container(
        margin: const EdgeInsets.only(left: 10),
        width: 80,
        height: 80,
        child: const Center(
          child: CircleAvatar(
            backgroundColor: Color.fromRGBO(225, 112, 51, 50),
            radius: 80,
            child:  Icon(Icons.shopify_sharp , size: 60,color: Colors.white,),

          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: const Text('Produit',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),),
      ),
      Container(
        padding: const EdgeInsets.only(left: 20),
        child: const Text('Remplire le formulaire pour ajouter un nouveau Produit.',style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.black
        ),),
      ),
      const SizedBox(
        height: 15.0,
      ),
      AppTextField(
        isCitySelected: true,
        cities: addproduceController.listOfCities,
        textEditingController: addproduceController.catTextEditingController,
        title: "Catégories",
        hint: "Choisir un catégorie",
      ),
      AppTextField(

        textEditingController: addproduceController.nameProductTextEditingController,
        title: "Nom du Produit",
        hint: "Enter nom produit",
        isCitySelected: false,
      ),
      AppTextField(
        textEditingController: addproduceController.descTextEditingController ,
        title: "Description",
        hint: "Description produit",
        isCitySelected: false,
      ),
      AppTextField(
        textEditingController: addproduceController.prixTextEditingController ,
        title: "Prix",
        hint: "Prix produit",
        isCitySelected: false,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: () {
            addproduceController.getImage();
          }, icon: const Icon(Icons.camera_alt),),
          SizedBox(

            child: addproduceController.image == null ? const Text('Choisir une image') : Image.file(addproduceController.image!),
          ),
        ],
      ),


      const SizedBox(height: 15.0,),
      BuildProgress(),
      const SizedBox(height: 15.0,),
      Center(
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.orange,
              side: const BorderSide(
                color: Colors.orange,
              ),
            ),
            onPressed:()   async {
              Map<String, String> body = {
                'title': addproduceController.nameProductTextEditingController.text};
              await service.addImage(addproduceController.image!.path);

              addproduceController.saveProrduct();

              },
            child: const Text("Ajouter produit",style: TextStyle(fontSize: 16),))

        ),

      const SizedBox(
        height: 15.0,
      ),
    ],
  ),
);