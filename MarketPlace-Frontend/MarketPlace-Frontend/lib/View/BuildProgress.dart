import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Controller/addproduceController.dart';

Widget BuildProgress() => StreamBuilder<TaskSnapshot> (
    stream: addProduceController().uploadTask?.snapshotEvents,
    builder:(context,snapshot){
      if (snapshot.hasData){
        final data = snapshot.data!;
        double progress = data.bytesTransferred/data.totalBytes;
        return SizedBox(
          height: 10,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(

                    value: progress,
                    backgroundColor: Colors.grey,
                    color:const Color.fromRGBO(255, 122, 51, 10)
                ),
              ),
              Center(
                child: Text(
                  '${(100*progress).roundToDouble()}%',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              )
            ],
          ),
        );
      }else{
        return const SizedBox(height: 10);
      }
    }
);