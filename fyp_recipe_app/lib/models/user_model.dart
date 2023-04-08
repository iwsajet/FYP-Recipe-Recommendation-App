class UserModel {
  String id;
  String email;
  String password;
  String fullname;
  String? username;
  UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.fullname,
      this.username});

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
