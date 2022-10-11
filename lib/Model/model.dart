// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

List<DataModel> dataModelFromJson(String str) =>
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  DataModel({
    required this.country,
    required this.webPages,
    required this.name,
    required this.alphaTwoCode,
    required this.domains,
  });

  String country;
  List<String> webPages;
  String name;
  String alphaTwoCode;
  List<String> domains;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        country: json["country"],
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        name: json["name"],
        alphaTwoCode: json["alpha_two_code"],
        domains: List<String>.from(json["domains"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
        "name": name,
        "alpha_two_code": alphaTwoCode,
        "domains": List<dynamic>.from(domains.map((x) => x)),
      };
}
