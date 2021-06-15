import 'dart:convert';


AnimeModel animeModelFromJson(String str) =>
    AnimeModel.fromJson(json.decode(str));

class AnimeModel {
  AnimeModel({
  required  this.aired,
  required  this.episodes,
  required  this.genres,
  required  this.imageUrl,
  required  this.malId,
  required  this.popularity,
  required  this.rank,
  required  this.related,
  required  this.score,
  required  this.source,
  required  this.status,
  required  this.synopsis,
  required  this.title,
  required  this.type,
  });

  List<String> aired;
  int episodes;
  List<String> genres;
  String imageUrl;
  int malId;
  int popularity;
  int rank;
  Related related;
  double score;
  String source;
  String status;
  String synopsis;
  String title;
  String type;

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        aired: List<String>.from(json["aired"].map((x) => x)),
        episodes: json["episodes"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        imageUrl: json["imageUrl"],
        malId: json["malId"],
        popularity: json["popularity"],
        rank: json["rank"],
        related: Related.fromJson(json["related"]),
        score: json["score"].toDouble(),
        source: json["source"],
        status: json["status"],
        synopsis: json["synopsis"],
        title: json["title"],
        type: json["type"],
      );

}
class Genre {
  Genre({
    required this.malId,
    required this.name,
    required this.type,
    required this.url,
  });

  int malId;
  String name;
  String type;
  String url;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        malId: json["mal_id"] == null ? null : json["mal_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
      );
}

class Related {
  Related({
    required this.adaptation,
    required this.alternativeSetting,
    required this.alternativeVersion,
    required this.character,
    required this.other,
    required this.parentStory,
    required this.prequel,
    required this.sequel,
    required this.sideStory,
    required this.spinOff,
    required this.summary,
    required this.fullStory,

  });

   List<Genre> adaptation;
  List<Genre> alternativeSetting;
  List<Genre> alternativeVersion;
  List<Genre> character;
  List<Genre> other;
  List<Genre> parentStory;
  List<Genre> prequel;
  List<Genre> sequel;
  List<Genre> sideStory;
  List<Genre> spinOff;
  List<Genre> summary;
    List<Genre> fullStory;

  factory Related.fromJson(Map<String, dynamic> json) => Related(
        adaptation:
            List<Genre>.from(json["Adaptation"].map((x) => Genre.fromJson(x))),
        alternativeSetting: List<Genre>.from(
            json["Alternative setting"].map((x) => Genre.fromJson(x))),
        alternativeVersion: List<Genre>.from(
            json["Alternative version"].map((x) => Genre.fromJson(x))),
        character:
            List<Genre>.from(json["Character"].map((x) => Genre.fromJson(x))),
        other: List<Genre>.from(json["Other"].map((x) => Genre.fromJson(x))),
        parentStory: List<Genre>.from(
            json["Parent story"].map((x) => Genre.fromJson(x))),
        prequel:
            List<Genre>.from(json["Prequel"].map((x) => Genre.fromJson(x))),
        sequel: List<Genre>.from(json["Sequel"].map((x) => Genre.fromJson(x))),
        sideStory:
            List<Genre>.from(json["Side story"].map((x) => Genre.fromJson(x))),
        spinOff:
            List<Genre>.from(json["Spin-off"].map((x) => Genre.fromJson(x))),
        summary:
            List<Genre>.from(json["Summary"].map((x) => Genre.fromJson(x))),
        fullStory:
            List<Genre>.from(json["Summary"].map((x) => Genre.fromJson(x))),
      );
}

