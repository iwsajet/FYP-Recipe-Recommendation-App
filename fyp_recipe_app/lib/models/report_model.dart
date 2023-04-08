class ReportModel {
  String fullname;
  String report;
  String recipeId;
  ReportModel({required this.fullname,required this.report, required this.recipeId});

  factory ReportModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return ReportModel(fullname: map['fullname'], report: map['report'], recipeId: map['recipeId']);
  }
}
