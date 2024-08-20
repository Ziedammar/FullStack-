class UserPost{
  late final String name;
  late final String email;
  late final String etat;
  late final String password;


  UserPost({
    required this.name,
    required this.email,
    required this.etat,
    required this.password,

  });
  Map<String, dynamic> toJson() =>
      {
        "name": name ,
        "email":email,
        "etat":etat,
        "password":password,

      };
  static UserPost fromJson(Map<String, dynamic>json)=> UserPost(
    name: json['name'],
      email: json['email'],
      etat: json['etat'],
      password: json['password'],
     );
}