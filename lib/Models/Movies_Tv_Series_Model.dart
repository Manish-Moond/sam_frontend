// To parse this JSON data, do
//
//     final MoviesTvSeriesModel = MoviesTvSeriesModelFromJson(jsonString);

import 'dart:convert';

MoviesTvSeriesModel moviesTvSeriesModelFromJson(String str) =>
    MoviesTvSeriesModel.fromJson(json.decode(str));

class MoviesTvSeriesModel {
  Dates? dates;
  int? page;
  List<MTSResultList>? results;
  int? totalPages;
  int? totalResults;

  MoviesTvSeriesModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MoviesTvSeriesModel.fromJson(Map<String, dynamic> json) =>
      MoviesTvSeriesModel(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<MTSResultList>.from(
                json["results"]!.map((x) => MTSResultList.fromJson(x))),
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

class MTSResultList {
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
  dynamic firstAirDate;
  String? title;
  String? name;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MTSResultList({
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
    this.firstAirDate,
    this.title,
    this.name,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MTSResultList.fromJson(Map<String, dynamic> json) => MTSResultList(
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
        firstAirDate: json["first_air_date"] == null
            ? DateTime.parse("2012-02-27 13:27:00.123456789z")
            : json["first_air_date"] == ''
                ? DateTime.parse("2012-02-27 13:27:00.123456789z")
                : DateTime.parse(json['first_air_date']),
        title: json["title"] == null ? " " : json["title"],
        name: json["name"] == null ? " " : json["name"],
        video: json["video"] == null ? false : json["video"],
        voteAverage: json["vote_average"]?.toDouble() == null
            ? 0.0
            : json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"] == null ? 0 : json["vote_count"],
      );
}
