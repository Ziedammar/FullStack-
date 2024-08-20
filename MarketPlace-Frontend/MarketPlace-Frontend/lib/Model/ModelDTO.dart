import 'package:flutter/foundation.dart';

class ArticleDTO {

  int? id;
  String name;
  int prix;
  String description;
  String categories;
  int image;
  String title;
  String url;

  ArticleDTO({
    this.id ,
    required this.name,
    required this.prix,
    required this.description,
    required this.categories,
    required this.image,
    required this.title,
    required this.url,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) {
    return ArticleDTO(
      id: json['id'],
      name: json['name'],
      prix: json['prix'] ,
      description: json['description'] ,
      categories: json['categories'] ,
      image: json['image'] ,
      title: json['title'] ,
      url: json['url'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'prix': prix,
      'description': description,
      'categories': categories,
      'image': image,
      'title': title,
      'url': url,
    };
  }
}
