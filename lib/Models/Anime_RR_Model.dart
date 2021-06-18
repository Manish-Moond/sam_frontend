// To parse this JSON data, do
//
//     final animeRModel = animeRModelFromJson(jsonString);

import 'dart:convert';

AnimeRRModel animeRModelFromJson(String str) =>
    AnimeRRModel.fromJson(json.decode(str));

String animeRModelToJson(AnimeRRModel data) => json.encode(data.toJson());

class AnimeRRModel {
  AnimeRRModel({
   required this.recommendedList,
  });

  List<int> recommendedList;

  factory AnimeRRModel.fromJson(Map<String, dynamic> json) => AnimeRRModel(
        recommendedList: List<int>.from(json["RecommendedList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "RecommendedList": List<dynamic>.from(recommendedList.map((x) => x)),
      };
}
