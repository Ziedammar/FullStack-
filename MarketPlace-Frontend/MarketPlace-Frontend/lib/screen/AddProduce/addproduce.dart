import 'package:eshop/Controller/addproduceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Service/Service.dart';
import '../../View/AddProduce.View.dart';



class addproduce extends GetView<addProduceController> {
  final addproduceController = Get.put(addProduceController());
  Service service = Service();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(225, 225, 225, 10),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: LayoutBuilder(builder: (BuildContext ,BoxConstraints) {
            return  SingleChildScrollView(
              child: SafeArea(
                child: mainBody(addproduceController , service),
              ),
            );
          }
            ,),
        )
    );
  }
}
