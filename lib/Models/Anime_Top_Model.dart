import 'dart:convert';

AnimeTopModel topAnimeModelFromJson(String str) =>
    AnimeTopModel.fromJson(json.decode(str));


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
}
