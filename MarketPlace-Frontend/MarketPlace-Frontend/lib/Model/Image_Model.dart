
class ImageModel{
  int? id;
  String? title;
  String? url;

  ImageModel(
      { required this.id,required this.title, required this.url});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    title= json['title'];
    url= json['url'];



  }
  Map<String, dynamic> toJson() {
    return {
      'id':0,
      'name': title,
      'url':url,

    };
  }

}