// To parse this JSON data, do
//
//     final animeModel = animeModelFromJson(jsonString);

import 'dart:convert';

AnimeModel animeModelFromJson(String str) =>
    AnimeModel.fromJson(json.decode(str));

String animeModelToJson(AnimeModel data) => json.encode(data.toJson());

class AnimeModel {
  AnimeModel({
    required this.requestHash,
    required this.requestCached,
    required this.requestCacheExpiry,
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.trailerUrl,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.aired,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.background,
    required this.premiered,
    required this.broadcast,
    required this.related,
    required this.producers,
    required this.licensors,
    required this.studios,
    required this.genres,
    required this.openingThemes,
    required this.endingThemes,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  int malId;
  String url;
  String imageUrl;
  String trailerUrl;
  String title;
  String titleEnglish;
  String titleJapanese;
  List<String> titleSynonyms;
  String type;
  String source;
  int episodes;
  String status;
  bool airing;
  Aired aired;
  String duration;
  String rating;
  double score;
  int scoredBy;
  int rank;
  int popularity;
  int members;
  int favorites;
  String synopsis;
  dynamic background;
  String premiered;
  String broadcast;
  Related related;
  List<Genre> producers;
  List<Genre> licensors;
  List<Genre> studios;
  List<Genre> genres;
  List<String> openingThemes;
  List<String> endingThemes;

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        malId: json["mal_id"],
        url: json["url"],
        imageUrl: json["image_url"],
        trailerUrl: json["trailer_url"],
        title: json["title"],
        titleEnglish: json["title_english"],
        titleJapanese: json["title_japanese"],
        titleSynonyms: List<String>.from(json["title_synonyms"].map((x) => x)),
        type: json["type"],
        source: json["source"],
        episodes: json["episodes"],
        status: json["status"],
        airing: json["airing"],
        aired: Aired.fromJson(json["aired"]),
        duration: json["duration"],
        rating: json["rating"],
        score: json["score"].toDouble(),
        scoredBy: json["scored_by"],
        rank: json["rank"],
        popularity: json["popularity"],
        members: json["members"],
        favorites: json["favorites"],
        synopsis: json["synopsis"],
        background: json["background"],
        premiered: json["premiered"],
        broadcast: json["broadcast"],
        related: Related.fromJson(json["related"]),
        producers:
            List<Genre>.from(json["producers"].map((x) => Genre.fromJson(x))),
        licensors:
            List<Genre>.from(json["licensors"].map((x) => Genre.fromJson(x))),
        studios:
            List<Genre>.from(json["studios"].map((x) => Genre.fromJson(x))),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        openingThemes: List<String>.from(json["opening_themes"].map((x) => x)),
        endingThemes: List<String>.from(json["ending_themes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "mal_id": malId,
        "url": url,
        "image_url": imageUrl,
        "trailer_url": trailerUrl,
        "title": title,
        "title_english": titleEnglish,
        "title_japanese": titleJapanese,
        "title_synonyms": List<dynamic>.from(titleSynonyms.map((x) => x)),
        "type": type,
        "source": source,
        "episodes": episodes,
        "status": status,
        "airing": airing,
        "aired": aired.toJson(),
        "duration": duration,
        "rating": rating,
        "score": score,
        "scored_by": scoredBy,
        "rank": rank,
        "popularity": popularity,
        "members": members,
        "favorites": favorites,
        "synopsis": synopsis,
        "background": background,
        "premiered": premiered,
        "broadcast": broadcast,
        "related": related.toJson(),
        "producers": List<dynamic>.from(producers.map((x) => x.toJson())),
        "licensors": List<dynamic>.from(licensors.map((x) => x.toJson())),
        "studios": List<dynamic>.from(studios.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "opening_themes": List<dynamic>.from(openingThemes.map((x) => x)),
        "ending_themes": List<dynamic>.from(endingThemes.map((x) => x)),
      };
}

class Aired {
  Aired({
    required this.from,
    required this.to,
    required this.prop,
    required this.string,
  });

  DateTime from;
  DateTime to;
  Prop prop;
  String string;

  factory Aired.fromJson(Map<String, dynamic> json) => Aired(
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        prop: Prop.fromJson(json["prop"]),
        string: json["string"],
      );

  Map<String, dynamic> toJson() => {
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
        "prop": prop.toJson(),
        "string": string,
      };
}

class Prop {
  Prop({
    required this.from,
    required this.to,
  });

  From from;
  From to;

  factory Prop.fromJson(Map<String, dynamic> json) => Prop(
        from: From.fromJson(json["from"]),
        to: From.fromJson(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from.toJson(),
        "to": to.toJson(),
      };
}

class From {
  From({
    required this.day,
    required this.month,
    required this.year,
  });

  int day;
  int month;
  int year;

  factory From.fromJson(Map<String, dynamic> json) => From(
        day: json["day"],
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
        "year": year,
      };
}

class Genre {
  Genre({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  int malId;
  String type;
  String name;
  String url;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        malId: json["mal_id"],
        type: json["type"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "type": typeValues.reverse[type],
        "name": name,
        "url": url,
      };
}

enum Type { ANIME, MANGA }

final typeValues = EnumValues({"anime": Type.ANIME, "manga": Type.MANGA});

class Related {
  Related({
    required this.adaptation,
    required this.alternativeVersion,
    required this.sideStory,
    required this.spinOff,
  });

  List<Genre> adaptation;
  List<Genre> alternativeVersion;
  List<Genre> sideStory;
  List<Genre> spinOff;

  factory Related.fromJson(Map<String, dynamic> json) => Related(
        adaptation:
            List<Genre>.from(json["Adaptation"].map((x) => Genre.fromJson(x))),
        alternativeVersion: List<Genre>.from(
            json["Alternative version"].map((x) => Genre.fromJson(x))),
        sideStory:
            List<Genre>.from(json["Side story"].map((x) => Genre.fromJson(x))),
        spinOff:
            List<Genre>.from(json["Spin-off"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Adaptation": List<dynamic>.from(adaptation.map((x) => x.toJson())),
        "Alternative version":
            List<dynamic>.from(alternativeVersion.map((x) => x.toJson())),
        "Side story": List<dynamic>.from(sideStory.map((x) => x.toJson())),
        "Spin-off": List<dynamic>.from(spinOff.map((x) => x.toJson())),
      };
}

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
