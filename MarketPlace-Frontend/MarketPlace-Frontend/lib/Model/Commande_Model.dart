
class Commande {
  final int id;
  final String user;
  final String article;
  final String qte;
  final int prix;
  final DateTime createdAt;
  final DateTime updatedAt;

  Commande({
    required this.id,
    required this.user,
    required this.article,
    required this.qte,
    required this.prix,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      user: json['User'],
      article: json['Article'],
      qte: json['qte'],
      prix: json['Prix'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': 0,
      'user': user,
      'article': article,
      'qte': qte,
      'prix': prix,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
