
class Favoris {
  int? id;
  int userid;
  int articleid;
  DateTime? createdat;
  DateTime? updatedat;

  Favoris({
    this.id,
    required this.userid,
    required this.articleid,
    this.createdat,
    this.updatedat,});

  factory Favoris.fromJson(Map<String, dynamic> json) {
    return Favoris(
        id: json['id'],
        userid: json['user_id'],
        articleid: json['article_id'],
        createdat: json['created_at'],
        updatedat: json['updated_at']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userid,
      'article_id': articleid,
      'created_at': createdat,
      'updated_at': updatedat,

    };
  }
}

