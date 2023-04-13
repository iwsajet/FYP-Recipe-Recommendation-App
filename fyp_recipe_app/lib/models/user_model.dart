class UserModel {
  String id;
  String email;
  String password;
  String fullname;
  
  UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.fullname,
     });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return UserModel(
      id: map['_id'],
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
    );
  }
}
