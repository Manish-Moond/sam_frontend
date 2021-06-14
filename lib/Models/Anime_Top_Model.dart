// // To parse this JSON data, do
// //
// //     final animeTopModel = animeTopModelFromJson(jsonString);

// import 'dart:convert';

// AnimeTopModel animeTopModelFromJson(String str) =>
//     AnimeTopModel.fromJson(json.decode(str));

// String animeTopModelToJson(AnimeTopModel data) => json.encode(data.toJson());

// class AnimeTopModel {
//   AnimeTopModel({
//     required this.requestHash,
//     required this.requestCached,
//     required this.requestCacheExpiry,
//     required this.top,
//   });

//   String requestHash;
//   bool requestCached;
//   int requestCacheExpiry;
//   List<Top> top;

//   factory AnimeTopModel.fromJson(Map<String, dynamic> json) => AnimeTopModel(
//         requestHash: json["request_hash"],
//         requestCached: json["request_cached"],
//         requestCacheExpiry: json["request_cache_expiry"],
//         top: List<Top>.from(json["top"].map((x) => Top.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "request_hash": requestHash,
//         "request_cached": requestCached,
//         "request_cache_expiry": requestCacheExpiry,
//         "top": List<dynamic>.from(top.map((x) => x.toJson())),
//       };
// }

// class Top {
//   Top({
//     required this.malId,
//     required this.rank,
//     required this.title,
//     required this.url,
//     required this.imageUrl,
//     required this.type,
//     required this.episodes,
//     required this.startDate,
//     required this.endDate,
//     required this.members,
//     required this.score,
//   });

//   int malId;
//   int rank;
//   String title;
//   String url;
//   String imageUrl;
//   Type type;
//   int episodes;
//   String startDate;
//   String endDate;
//   int members;
//   double score;

//   factory Top.fromJson(Map<String, dynamic> json) => Top(
//         malId: json["mal_id"],
//         rank: json["rank"],
//         title: json["title"],
//         url: json["url"],
//         imageUrl: json["image_url"],
//         type: json["type"],
//         episodes: json["episodes"],
//         startDate: json["start_date"],
//         endDate: json["end_date"],
//         members: json["members"],
//         score: json["score"].toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "mal_id": malId,
//         "rank": rank,
//         "title": title,
//         "url": url,
//         "image_url": imageUrl,
//         "type": typeValues.reverse[type],
//         "episodes": episodes,
//         "start_date": startDate,
//         "end_date": endDate,
//         "members": members,
//         "score": score,
//       };
// }

// enum Type { TV, OVA, MOVIE }

// final typeValues =
//     EnumValues({"Movie": Type.MOVIE, "OVA": Type.OVA, "TV": Type.TV});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }


// To parse this JSON data, do
//
//     final topAnimeModel = topAnimeModelFromJson(jsonString);

import 'dart:convert';

AnimeTopModel topAnimeModelFromJson(String str) =>
    AnimeTopModel.fromJson(json.decode(str));

String animeTopModelToJson(AnimeTopModel data) => json.encode(data.toJson());

class AnimeTopModel {
  AnimeTopModel({
    required this.requestHash,
    required this.requestCached,
    required this.requestCacheExpiry,
    required this.top,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Top> top;

  factory AnimeTopModel.fromJson(Map<String, dynamic> json) => AnimeTopModel(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        top: List<Top>.from(json["top"].map((x) => Top.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "top": List<dynamic>.from(top.map((x) => x.toJson())),
      };
}

class Top {
  Top({
    required this.malId,
    required this.rank,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.type,
    required this.episodes,
    required this.startDate,
    required this.endDate,
    required this.members,
    required this.score,
  });

  int malId;
  int rank;
  String title;
  String url;
  String imageUrl;
  String type;
  int episodes;
  String startDate;
  String endDate;
  int members;
  double score;

  factory Top.fromJson(Map<String, dynamic> json) => Top(
        malId: json["mal_id"],
        rank: json["rank"],
        title: json["title"],
        url: json["url"],
        imageUrl: json["image_url"],
        type: json["type"],
        episodes: json["episodes"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        members: json["members"],
        score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "rank": rank,
        "title": title,
        "url": url,
        "image_url": imageUrl,
        "type": typeValues.reverse[type],
        "episodes": episodes,
        "start_date": startDate,
        "end_date": endDate,
        "members": members,
        "score": score,
      };
}

enum Type { TV, OVA, MOVIE }

final typeValues =
    EnumValues({"Movie": Type.MOVIE, "OVA": Type.OVA, "TV": Type.TV});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);
  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
