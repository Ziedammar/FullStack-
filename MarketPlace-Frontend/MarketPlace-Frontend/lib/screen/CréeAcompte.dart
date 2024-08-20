import 'package:eshop/Controller/User_Controller.dart';
import 'package:eshop/Model/UserPost_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Login_Categories.dart';
import '../Model/User_Model.dart';
import 'Auth/FournisseurPage.dart';

class CreeAcompte extends StatefulWidget {
  @override
  State<CreeAcompte> createState() => _CreeAcompteState();
}

class _CreeAcompteState extends State<CreeAcompte> {
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_login = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  late UserPost data ;

  bool Etat = true;
  static String? name;
  static String? login;
  static  String? pwd ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Color.fromRGBO(255, 122, 51, 10))),
          title: const Text(
            'Créer nouveau compte',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(255, 122, 51, 10),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
                child: TextField(
                  controller: txt_name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "Nom",
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: "Nom Utilisateur",
                  ),
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  maxLength: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
                child: TextField(
                  controller: txt_login,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.alternate_email),
                    hintText: "Identifiant ",
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: "Identifiant",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  maxLength: 50,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
                child: TextField(
                  controller: txt_password,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          Etat = !Etat;
                        });
                      },
                      icon: const Icon(Icons.visibility),
                    ),
                    hintText: "Mot de Passe",
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    labelText: "mot de passe",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: Etat,
                  maxLength: 10,
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(
                      width: 1, color: Color.fromRGBO(255, 122, 51, 100)),
                ),
                onPressed: () async {

                  try  {
                     name = txt_name.text;
                     login = txt_login.text;
                     pwd = txt_password.text;
                    data =UserPost(
                    name : name!,
                    email : login!,
                    etat : 'Client',
                    password:pwd!
                    );

                    await UserController().postUser(data);
                  } on Exception catch (e) {
                    print(e);
                    throw Exception("Error on server");
                  }
                  await LoginController().postLogin(login!, pwd!);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');



                  print('connect');
                },
                child: const Text(
                  "Crée un compte",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 122, 51, 10),
                    fontFamily: 'Aboret',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(width: 30,),
                  TextButton(
                      child: const Text(
                        "J'ai deja un compte",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 122, 51, 10),
                        ),
                      ),
                      onPressed: () => {
                      Get.to(() => FournisseurPage()),

                      }
                  )
                ],
              ),

            ])));
  }
}
