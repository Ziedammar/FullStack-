import 'package:eshop/Model/Product_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controller/Cart_Controller.dart';
import '../../Controller/Categories_Controller.dart';
import '../../Controller/Product_Controller.dart';
import '../../Model/ModelDTO.dart';
import '../../View/Card_View.dart';
class AllProduct extends StatefulWidget {
  String desc ='';
   AllProduct(this.desc, {Key? key}) : super(key: key);

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  static String descValue ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descValue=widget.desc ;
  }
  final Future<List<ArticleDTO>> _calculation = Future<List<ArticleDTO>>.delayed(
    const Duration(seconds: 3),
        () => ProductController().getAllProduct(),
  );
  final Future<List<ArticleDTO>> _calculation1 = Future<List<ArticleDTO>>.delayed(
    const Duration(seconds: 3),
        () => ProductController().getAllProductbycat(descValue),
  );

  @override
  Widget build(BuildContext context) {

    final cartController = Get.put(CartController());
    final categoriesController = Get.put(CategoriesController());

    return FutureBuilder<List<ArticleDTO>>(
      future: descValue =="Tous les produits" ? _calculation : _calculation1  ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while the future is not yet complete
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Display an error message if an error occurred
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Display the data in a ListView if the future completed successfully
          final product = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: product.length,
            itemBuilder: (context, index) =>

                CardView(context, index, cartController, categoriesController, product),
          );
        } else {
          // This should never happen, but just in case, display a default message
          return Text('Unknown error');
        }
      },
    );

  }
}
