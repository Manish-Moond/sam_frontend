// To parse this JSON data, do
//
//     final popularPersonModel = popularPersonModelFromJson(jsonString);

import 'dart:convert';

PersonPopularModel popularPersonModelFromJson(String str) =>
    PersonPopularModel.fromJson(json.decode(str));

class PersonPopularModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  PersonPopularModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PersonPopularModel.fromJson(Map<String, dynamic> json) =>
      PersonPopularModel(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Result {
  bool? adult;
  int? gender;
  int? id;
  List<KnownFor>? knownFor;
  String? knownForDepartment;
  String? name;
  double? popularity;
  String? profilePath;

  Result({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownFor: json["known_for"] == null
            ? []
            : List<KnownFor>.from(
                json["known_for"]!.map((x) => KnownFor.fromJson(x))),
        knownForDepartment: json["known_for_department"]!,
        name: json["name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
      );
}

class KnownFor {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  DateTime? firstAirDate;
  String? name;
  List<String>? originCountry;
  String? originalName;

  KnownFor({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalName,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        adult: json["adult"] == null ? true : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? "" : json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        mediaType: json["media_type"]! == null ? "" : json["media_type"]!,
        originalLanguage: json["original_language"]! == null
            ? ""
            : json["original_language"]!,
        // originalTitle: json["original_title"] ? "" : json["original_title"],
        // overview: json["overview"]! ? "" : json["overview"]!,
        // posterPath: json["poster_path"] ? "" : json["poster_path"],
        // releaseDate: json["release_date"] == null
        //     ? DateTime.parse("1000-02-22")
        //     : DateTime.parse(json["release_date"]),
        // title: json["title"] == null ? "" : json["title"],
        // video: json["video"] == null ? false : json["video"],
        // voteAverage: json["vote_average"]?.toDouble() == null
        //     ? 0.0
        //     : json["vote_average"]?.toDouble(),
        // voteCount: json["vote_count"] == null ? 0 : json["vote_count"],
        // firstAirDate: json["first_air_date"] == null
        //     ? null
        //     : DateTime.parse(json["first_air_date"]),
        // name: json["name"] == null ? "Manish Moond" : json["name"],
        // originCountry: json["origin_country"] == null
        //     ? []
        //     : List<String>.from(json["origin_country"]!.map((x) => x)),
        // originalName:
        //     json["original_name"] == null ? "Vision" : json["original_name"],
      );
}
