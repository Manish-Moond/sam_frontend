// To parse this JSON data, do
//
//     final moviesModel = moviesModelFromJson(jsonString);

import 'dart:convert';

MoviesModel moviesModelFromJson(String str) =>
    MoviesModel.fromJson(json.decode(str));

class MoviesModel {
  Dates? dates;
  int? page;
  List<MoviesResultList>? results;
  int? totalPages;
  int? totalResults;

  MoviesModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<MoviesResultList>.from(
                json["results"]!.map((x) => MoviesResultList.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum:
            json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
        minimum:
            json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
      );
}

class MoviesResultList {
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

  MoviesResultList({
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
  });

  factory MoviesResultList.fromJson(Map<String, dynamic> json) =>
      MoviesResultList(
        adult: json["adult"] == null ? true : json['adult'],
        backdropPath:
            json["backdrop_path"] == null ? "" : json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"] == null ? 0 : json['id'],
        originalLanguage:
            json["original_language"]! == null ? "" : json["original_language"],
        originalTitle:
            json["original_title"] == null ? "" : json["original_title"],
        overview: json["overview"] == null ? "" : json["overview"],
        popularity: json["popularity"]?.toDouble() == null
            ? 0.0
            : json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] == null ? "" : json["poster_path"],
        releaseDate: json["release_date"] == null
            ? DateTime.parse("2012-02-27 13:27:00.123456789z")
            : DateTime.parse(json["release_date"]),
        title: json["title"] == null ? " " : json["title"],
        video: json["video"] == null ? false : json["video"],
        voteAverage: json["vote_average"]?.toDouble() == null
            ? 0.0
            : json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"] == null ? 0 : json["vote_count"],
      );
}
