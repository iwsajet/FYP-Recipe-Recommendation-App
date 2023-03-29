class CommentModel {
  String? fullname;
  String? comment;
  
  CommentModel({this.fullname, this.comment});

  factory 
  CommentModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return 
    CommentModel(fullname: map['fullname'], comment: map['comment']);
  }
}
