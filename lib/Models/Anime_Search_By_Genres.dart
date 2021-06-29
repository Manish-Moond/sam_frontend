import 'dart:convert';

AnimeSearchByGenres animeSearchByGenresFromJson(String str) =>
    AnimeSearchByGenres.fromJson(json.decode(str));


class AnimeSearchByGenres {
  AnimeSearchByGenres({
   required this.results,
  });

  List<Result> results;

  factory AnimeSearchByGenres.fromJson(Map<String, dynamic> json) =>
      AnimeSearchByGenres(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

}

class Result {
  Result({
   required this.airing,
   required this.endDate,
   required this.episodes,
   required this.imageUrl,
   required this.malId,
   required this.members,
   required this.rated,
   required this.score,
   required this.startDate,
   required this.synopsis,
   required this.title,
   required this.type,
   required this.url,
  });

  bool airing;
  DateTime endDate;
  int episodes;
  String imageUrl;
  int malId;
  int members;
  String rated;
  double score;
  DateTime startDate;
  String synopsis;
  String title;
  Type type;
  String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        airing: json["airing"],
        endDate: DateTime.parse(json["end_date"]),
        episodes: json["episodes"],
        imageUrl: json["image_url"],
        malId: json["mal_id"],
        members: json["members"],
        rated: json["rated"],
        score: json["score"].toDouble(),
        startDate: DateTime.parse(json["start_date"]),
        synopsis: json["synopsis"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );
}

// enum Rated { YCW, R, PG_13, PG, G }

// final ratedValues = EnumValues({
//   "G": Rated.G,
//   "PG": Rated.PG,
//   "PG-13": Rated.PG_13,
//   "R": Rated.R,
//   "ycw": Rated.YCW
// });

// enum Type { ONA, SPECIAL, MOVIE, OVA, TV }

// final typeValues = EnumValues({
//   "Movie": Type.MOVIE,
//   "ONA": Type.ONA,
//   "OVA": Type.OVA,
//   "Special": Type.SPECIAL,
//   "TV": Type.TV
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//    EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
