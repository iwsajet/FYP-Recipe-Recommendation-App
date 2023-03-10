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
}
