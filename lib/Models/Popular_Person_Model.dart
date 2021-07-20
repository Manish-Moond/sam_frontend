// To parse this JSON data, do
//
//     final popularPersonModel = popularPersonModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PopularPersonModel popularPersonModelFromJson(String str) =>
    PopularPersonModel.fromJson(json.decode(str));

class PopularPersonModel {
  PopularPersonModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  factory PopularPersonModel.fromJson(Map<String, dynamic> json) =>
      PopularPersonModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Result {
  Result({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });

  final bool? adult;
  final int? gender;
  final int? id;
  final List<KnownFor>? knownFor;
  final String? knownForDepartment;
  final String? name;
  final double? popularity;
  final String? profilePath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownFor: List<KnownFor>.from(
            json["known_for"].map((x) => KnownFor.fromJson(x))),
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
      );
}

class KnownFor {
  KnownFor({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.name,
    required this.originCountry,
    required this.originalName,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final DateTime? firstAirDate;
  final String? name;
  final List? originCountry;
  final String? originalName;

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        adult: json["adult"] == null ? false : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? ' ' : json["backdrop_path"],
        genreIds: json['genre_ids'] == null
            ? [100]
            : List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        mediaType: json["media_type"] == null ? ' ' : json['media_type'],
        originalLanguage: json["original_language"] == null
            ? 'en'
            : json['original_language'],
        originalTitle:
            json["original_title"] == null ? 'manish' : json["original_title"],
        overview: json["overview"] == null ? ' ' : json['overview'],
        posterPath: json["poster_path"] == null ? ' ' : json['poster_path'],
        releaseDate: json["release_date"] == null
            ? DateTime.parse('2012-04-25')
            : DateTime.parse(json["release_date"]),
        title: json["title"] == null ? 'manish' : json["title"],
        video: json["video"] == null ? false : json["video"],
        voteAverage: json["vote_average"] == null
            ? 0.0
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? 0.0 : json['vote_counts'],
        firstAirDate: json["first_air_date"] == null
            ? DateTime.parse('2012-04-25')
            : DateTime.parse(json["first_air_date"]),
        name: json["name"] == null ? 'manish' : json["name"],
        originCountry:
            json["origin_country"] == null ? ['IN'] : json["origin_country"],
        originalName:
            json["original_name"] == null ? 'Manish' : json["original_name"],
      );
}
