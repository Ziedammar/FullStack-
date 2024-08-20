class User{
  late final String name;
  late final String email;
  late final String etat;
  
  late final String created_at;
  late final String updated_at;
  User({
    required this.name,
    required this.email,
    required this.etat,
    required this.created_at,
    required this.updated_at,
  });
  Map<String, dynamic> toJson() =>
      {
        "name": name ,
        "email":email,
        "etat":etat,
        "created_at":created_at,
        "imagename":updated_at,
      };
  static User fromJson(Map<String, dynamic>json)=> User(
      name: json['name'],
      email: json['email'],
      etat: json['etat'],
      created_at: json['created_at'],
      updated_at: json['updated_at']);
}