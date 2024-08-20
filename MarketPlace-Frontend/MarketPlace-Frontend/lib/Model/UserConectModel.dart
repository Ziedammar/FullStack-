class   UserC {
  int? id;
  String? name;
  String? email;
  String? etat;
  String? createdAt;
  String? updatedAt;

  UserC({
    required this.id,
    required this.name,
    required this.email,
    required this.etat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserC.fromJson(Map<String, dynamic> json)  {
    return UserC (
      id : json['id'],
      name : json['name'],
      email : json['email'],
      etat : json['etat'],
      createdAt : json['created_at'],
      updatedAt : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'etat': etat,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
