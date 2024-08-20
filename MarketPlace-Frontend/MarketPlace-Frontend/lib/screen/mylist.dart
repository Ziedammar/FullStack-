import 'package:eshop/Controller/User_Controller.dart';
import 'package:eshop/Model/User_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../View/GetImage.dart';
class mylist extends StatelessWidget {
  const mylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (value){
          return FutureBuilder<List<User>>(
            future: value.getUser(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                print("${snapshot.error}");

                return const Text('error');}
              else if (snapshot. hasData){
                final users = snapshot.data!;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics() ,
                    itemCount: users.length,
                    itemBuilder: (context ,index) =>
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20),
                              ), color: Colors.grey.shade200,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black26
                                )
                              ]
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: Text((index+1).toString() ,style: const TextStyle(fontSize: 18 , color: Colors.white),),
                                backgroundColor: Colors.blueGrey,
                              ),
                              const SizedBox(width: 20,),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(users[index].name , style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                                  Text(users[index].email , style: const TextStyle(fontSize: 12 ,color: Colors.black54 ),),
                                  Text("Role: ${users[index].etat}"),


                                ],
                              ))
                            ],
                          ),
                        )
                );
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },);
        });
  }
}
