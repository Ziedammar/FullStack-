import 'dart:convert';

import 'package:eshop/Controller/ImageController.dart';
import 'package:eshop/Model/Image_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetImage extends StatefulWidget {
  GetImage(this.imageId, {Key? key}) : super(key: key);
  int imageId;

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  final imageController = Get.put(ImageController());

  late final ImageController _imageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageController = ImageController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageModel>>(
      future: _imageController.getImage(widget.imageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while the future is not yet complete
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Display an error message if an error occurred
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Display the data in a ListView if the future completed successfully
          final image = snapshot.data!;
          return Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: image.length,
                  itemBuilder: (context, index) => Image.memory(
                    base64Decode(image[0].url.toString()),
                    width: 150,
                    height: 150,
                  )));
        } else {
          // This should never happen, but just in case, display a default message
          return Text('Unknown error');
        }
      },
    );
  }
}
