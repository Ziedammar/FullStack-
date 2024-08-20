import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:eshop/screen/mylist.dart';
import 'package:flutter/material.dart';

import '../../Controller/User_Controller.dart';
import '../AddProduce/addproduce.dart';
import '../Statistique.dart';
class EspaceFr extends StatefulWidget {

  const EspaceFr({Key? key}) : super(key: key);

  @override
  State<EspaceFr> createState() => _EspaceFrState();
}
int _page = 0;
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


class _EspaceFrState extends State<EspaceFr> {
  var page ;


  void setbodyPage(){
    switch(_page){
      case 0:
        page= addproduce();
        break;
      case 1:
        page= const mylist();   break;
      case 2:
        page= const Statistique();   break;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(225, 225, 225, 10),
        key: _bottomNavigationKey,
        items: [
          CurvedNavigationBarItem(icon: const Icon(Icons.add, size: 30), label: "Add" ,),
          CurvedNavigationBarItem(icon: const Icon(Icons.list, size: 30), label: "List"),
          CurvedNavigationBarItem(icon: const Icon(Icons.multiline_chart, size: 30), label: "Chart"),

        ],

        buttonBackgroundColor: const Color.fromRGBO(255, 122, 51, 50),
        buttonLabelColor: const Color.fromRGBO(255, 122, 51, 50) ,

        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 1000),
        onTap: (index) {
          setState(() {

            _page = index;
            setbodyPage();
            print(_page);
          });
        },
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context,'/home');
            }, icon:const Icon(Icons.arrow_back_ios , color:Color.fromRGBO(225, 225, 225, 10) )),
        title: const Text('',style: TextStyle(
          fontSize: 16,
          color: Colors.white,

        ),),
        backgroundColor: const Color.fromRGBO(255, 122, 51, 30),
        elevation: 2,
        actions: <Widget>[
          IconButton(onPressed: () async {
            await UserController().LogOut();
            Navigator.of(context).pop();
            Navigator.pushNamed(context,'/home');

          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        color:const Color.fromRGBO(225, 225, 225, 10),
        child: Center(
          child: Flexible(
            child: (_page ==0 ? addproduce(): page),

          ),
        ),
      ),
    );
  }
}
