class ReportModel {
  String? fullname;
  String? report;
  ReportModel({this.fullname, this.report});

  factory ReportModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return ReportModel(fullname: map['fullname'], report: map['report']);
  }
}
