class BookmarkModel{
  String recipeId;
  String userId;
  BookmarkModel({required this.recipeId, required this.userId});
  factory BookmarkModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return BookmarkModel(recipeId: map['recipeId'], userId: map['userId']);
  }
}
