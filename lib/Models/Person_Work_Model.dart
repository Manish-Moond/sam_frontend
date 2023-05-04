// To parse this JSON data, do
//
//     final personWorkModel = personWorkModelFromJson(jsonString);

import 'dart:convert';

PersonWorkModel personWorkModelFromJson(String str) =>
    PersonWorkModel.fromJson(json.decode(str));

class PersonWorkModel {
  List<Work>? work;
  List<Crew>? crew;
  int? id;

  PersonWorkModel({
    this.work,
    this.crew,
    this.id,
  });

  factory PersonWorkModel.fromJson(Map<String, dynamic> json) =>
      PersonWorkModel(
        work: json["cast"] == null
            ? []
            : List<Work>.from(json["cast"]!.map((x) => Work.fromJson(x))),
        crew: json["crew"] == null
            ? []
            : List<Crew>.from(json["crew"]!.map((x) => Crew.fromJson(x))),
        id: json["id"],
      );
}

class Work {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  dynamic posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? creditId;
  int? order;

  Work({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.character,
    this.creditId,
    this.order,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        adult: json["adult"] == null ? true : json['adult'],
        backdropPath:
            json["backdrop_path"] == null ? "" : json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage:
            json["original_language"] == null ? "" : json["original_language"],
        originalTitle:
            json["original_title"] == null ? "" : json["original_title"],
        overview: json["overview"] == null ? "" : json["overview"],
        popularity: json["popularity"]?.toDouble() == null
            ? 0.0
            : json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] == null ? "" : json["poster_path"],
        releaseDate: json["release_date"] == ""
            ? DateTime.parse("2012-02-27 13:27:00,123456789z")
            : DateTime.parse(json["release_date"]),
        title: json["title"] == null ? "" : json["title"],
        video: json["video"] == null ? false : json["video"],
        voteAverage: json["vote_average"]?.toDouble() == null
            ? 0.0
            : json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"] == null ? 0 : json["vote_count"],
        character: json["character"] == null ? "" : json["character"],
        creditId: json["credit_id"] == null ? "" : json["credite_id"],
        order: json["order"] == null ? 0 : json["order"],
      );
}

class Crew {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? creditId;
  String? department;
  String? job;

  Crew({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.creditId,
    this.department,
    this.job,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] == ""
            ? DateTime.parse("2012-02-02")
            : DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        creditId: json["credit_id"],
        department: json["department"],
        job: json["job"],
      );
}
