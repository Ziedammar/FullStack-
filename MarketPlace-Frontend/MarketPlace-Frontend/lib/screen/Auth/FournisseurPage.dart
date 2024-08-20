import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/Login_Categories.dart';
import '../../Controller/User_Controller.dart';
import '../CréeAcompte.dart';

class FournisseurPage extends StatefulWidget {
  @override
  State<FournisseurPage> createState() => _FournisseurPageState();
}

class _FournisseurPageState extends State<FournisseurPage> {
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

  bool Etat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: Color.fromRGBO(255, 122, 51, 10))),
          title: Text(
            'Authentification',
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
            padding: EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
            child: TextField(
              controller: txt_login,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Identifiant ",
                labelStyle: TextStyle(
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
            padding: EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
            child: TextField(
              controller: txt_password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      Etat = !Etat;
                    });
                  },
                  icon: Icon(Icons.visibility),
                ),
                hintText: "Mot de Passe",
                labelStyle: TextStyle(
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
              shape: StadiumBorder(),
              side: BorderSide(
                  width: 1, color: Color.fromRGBO(255, 122, 51, 100)),
            ),
            onPressed: () async {
              try {
                print('Connecting');
                String login = txt_login.text;
                String pwd = txt_password.text;
                await LoginController().postLogin(login, pwd);
                await UserController().getContUser();
                if (UserController.Role == "Admin") {Navigator.pop(context);
                Navigator.pushNamed(context, '/EspaceFr');}
                else {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');

                }

              } on Exception catch (e) {
                print(e);
                throw Exception("Error on server");
              }

              print('connect');
            },
            child: Text(
              "Connexion",
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
              TextButton(
                child: Text(
                  'Mot de Passe Oublié',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 122, 51, 10),
                  ),
                ),
                onPressed: () {}
              ),
              SizedBox(
                width: 30,
              ),
              TextButton(
                  child: const Text(
                    'Créer un compte ',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 122, 51, 10),
                    ),
                  ),
                  onPressed: () => {
                        Get.to(() => CreeAcompte()),
                      })
            ],
          ),
        ])));
  }
}
