// // To parse this JSON data, do
// //
// //     final personModel = personModelFromJson(jsonString);

// import 'dart:convert';

// PersonModel personModelFromJson(String str) =>
//     PersonModel.fromJson(json.decode(str));

// class PersonModel {
//   PersonModel({
//     required this.work,
//   });

//   final List<Work> work;

//   factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
//         work: List<Work>.from(json["work"].map((x) => Work.fromJson(x))),
//       );
// }

// class Work {
//   Work({
//     required this.adult,
//     required this.backdropPath,
//     required this.genreIds,
//     required this.id,
//     required this.originalLanguage,
//     required this.originalTitle,
//     required this.overview,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.title,
//   });

//   final bool adult;
//   final String backdropPath;
//   final List<int> genreIds;
//   final int id;
//   final String originalLanguage;
//   final String originalTitle;
//   final String overview;
//   final String posterPath;
//   final DateTime releaseDate;
//   final String title;

//   factory Work.fromJson(Map<String, dynamic> json) => Work(
//         adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         originalLanguage: json["original_language"],
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         posterPath: json["poster_path"],
//         releaseDate: DateTime.parse(json["release_date"]),
//         title: json["title"],
//       );
// }


// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

import 'dart:convert';

PersonWorkModel personModelFromJson(String str) =>
    PersonWorkModel.fromJson(json.decode(str));


class PersonWorkModel {
  PersonWorkModel({
    required this.cast,
    required this.crew,
    required this.id,
  });

  final List<Cast> cast;
  final List<Cast> crew;
  final int id;

  factory PersonWorkModel.fromJson(Map<String, dynamic> json) => PersonWorkModel(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
        id: json["id"],
      );

}

class Cast {
  Cast({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final String character;
  final String creditId;
  final int order;
  final String department;
  final String job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"] == null ? false : json['adult'],
        backdropPath:
            json["backdrop_path"] == null ? ' ' : json["backdrop_path"],
        genreIds: json['genre_id'] == null? [100]:  List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"] == null ? ' ': json['original_language'],
        originalTitle: json["original_title"] == null? ' ': json['original_title'],
        overview: json["overview"] == null ? ' ': json['overview'],
        posterPath: json["poster_path"] == null ? ' ' : json["poster_path"],
        releaseDate: json["release_date"] == null ? ' ' : json['release_date'],
        title: json["title"] == null? ' ': json['title'],
        video: json["video"] == null? false: json["poster_path"],
        voteAverage: json["vote_average"] == null ? 0.0 : json['vote_average'].toDouble(),
        voteCount: json["vote_count"] == null? 0: json['vote_count'] ,
        popularity: json["popularity"] == null? 0.0 : json['popularity'].toDouble(),
        character: json["character"] == null ? ' ' : json["character"],
        creditId: json["credit_id"] == null ? ' ': json['credit_id'],
        order: json["order"] == null ? ' ' : json["order"],
        department: json["department"] == null ? ' ' : json["department"],
        job: json["job"] == null ? ' ' : json["job"],
      );

}
