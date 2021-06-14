import 'dart:convert';

AnimeRRModel animeRRModelFromJson(String str) =>
    AnimeRRModel.fromJson(json.decode(str));

class AnimeRRModel {
  AnimeRRModel({
    required this.malId,
  });

  int malId;

  factory AnimeRRModel.fromJson(Map<String, dynamic> json) =>
      AnimeRRModel(
        malId: json["malId"],
      );
}
