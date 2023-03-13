class UserModel {
  String email;
  String password;
  String? fullname;
  String? username;
  UserModel(
      {required this.email,
      required this.password,
      this.fullname,
      this.username});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(email: map['email'], password: map['password']);
  }
}
