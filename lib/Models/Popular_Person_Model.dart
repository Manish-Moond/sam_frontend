// To parse this JSON data, do
//
//     final popularPersonModel = popularPersonModelFromJson(jsonString);

import 'dart:convert';

PopularPersonModel popularPersonModelFromJson(String str) =>
    PopularPersonModel.fromJson(json.decode(str));

String popularPersonModelToJson(PopularPersonModel data) =>
    json.encode(data.toJson());

class PopularPersonModel {
  PopularPersonModel({
    required this.results,
  });

  final List<Result> results;

  factory PopularPersonModel.fromJson(Map<String, dynamic> json) =>
      PopularPersonModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String profilePath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_path": profilePath,
      };
}
