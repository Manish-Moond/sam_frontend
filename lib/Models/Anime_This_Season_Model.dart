// To parse this JSON data, do
//
//     final animeThisSeason = animeThisSeasonFromJson(jsonString);

import 'dart:convert';

AnimeThisSeasonModel animeThisSeasonFromJson(String str) =>
    AnimeThisSeasonModel.fromJson(json.decode(str));
class AnimeThisSeasonModel {
  AnimeThisSeasonModel({
    required this.anime,
  });

  List<Anime> anime;

  factory AnimeThisSeasonModel.fromJson(Map<String, dynamic> json) =>
      AnimeThisSeasonModel(
        anime: List<Anime>.from(json["anime"].map((x) => Anime.fromJson(x))),
      );


}

class Anime {
  Anime({
  required  this.airingStart,
  required  this.episodes,
  required  this.genres,
  required  this.imageUrl,
  required  this.malId,
  required  this.members,
  required  this.score,
  required  this.synopsis,
  required  this.title,
  required  this.type,
  required  this.url,
  });

  DateTime airingStart;
  int episodes;
  List<String> genres;
  String imageUrl;
  int malId;
  int members;
  double score;
  String synopsis;
  String title;
  String type;
  String url;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        airingStart: DateTime.parse(json["airing_start"]),
        episodes: json["episodes"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        imageUrl: json["image_url"],
        malId: json["mal_id"],
        members: json["members"],
        score: json["score"].toDouble(),
        synopsis: json["synopsis"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );

}

// enum Type { TV, ONA, OVA, MOVIE, SPECIAL, EMPTY }

// final typeValues = EnumValues({
//   "-": Type.EMPTY,
//   "Movie": Type.MOVIE,
//   "ONA": Type.ONA,
//   "OVA": Type.OVA,
//   "Special": Type.SPECIAL,
//   "TV": Type.TV
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//  late EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
