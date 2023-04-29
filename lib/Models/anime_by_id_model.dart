// To parse this JSON data, do
//
//     final animeModel = animeModelFromJson(jsonString);

import 'dart:convert';

AnimeModel animeModelFromJson(String str) =>
    AnimeModel.fromJson(json.decode(str));

class AnimeModel {
  AnimeModel({
    this.data,
  });

  Data? data;

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.malId,
    this.url,
    this.images,
    this.trailer,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.broadcast,
    this.producers,
    this.licensors,
    this.studios,
    this.genres,
    this.explicitGenres,
    this.themes,
    this.demographics,
  });

  int? malId;
  String? url;
  Map<String, Image>? images;
  Trailer? trailer;
  bool? approved;
  List<Title>? titles;
  String? title;
  String? titleEnglish;
  String? titleJapanese;
  List<String>? titleSynonyms;
  String? type;
  String? source;
  int? episodes;
  String? status;
  bool? airing;
  Aired? aired;
  String? duration;
  String? rating;
  double? score;
  int? scoredBy;
  int? rank;
  int? popularity;
  int? members;
  int? favorites;
  String? synopsis;
  String? background;
  String? season;
  int? year;
  Broadcast? broadcast;
  List<Demographic>? producers;
  List<Demographic>? licensors;
  List<Demographic>? studios;
  List<Demographic>? genres;
  List<dynamic>? explicitGenres;
  List<Demographic>? themes;
  List<Demographic>? demographics;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]!)
            .map((k, v) => MapEntry<String, Image>(k, Image.fromJson(v))),
        trailer:
            json["trailer"] == null ? null : Trailer.fromJson(json["trailer"]),
        approved: json["approved"],
        titles: json["titles"] == null
            ? []
            : List<Title>.from(json["titles"]!.map((x) => Title.fromJson(x))),
        title: json["title"],
        titleEnglish: json["title_english"],
        titleJapanese: json["title_japanese"],
        titleSynonyms: json["title_synonyms"] == null
            ? []
            : List<String>.from(json["title_synonyms"]!.map((x) => x)),
        type: json["type"],
        source: json["source"],
        episodes: json["episodes"],
        status: json["status"],
        airing: json["airing"],
        aired: json["aired"] == null ? null : Aired.fromJson(json["aired"]),
        duration: json["duration"],
        rating: json["rating"],
        score: json["score"]?.toDouble(),
        scoredBy: json["scored_by"],
        rank: json["rank"],
        popularity: json["popularity"],
        members: json["members"],
        favorites: json["favorites"],
        synopsis: json["synopsis"],
        background: json["background"],
        season: json["season"],
        year: json["year"],
        broadcast: json["broadcast"] == null
            ? null
            : Broadcast.fromJson(json["broadcast"]),
        producers: json["producers"] == null
            ? []
            : List<Demographic>.from(
                json["producers"]!.map((x) => Demographic.fromJson(x))),
        licensors: json["licensors"] == null
            ? []
            : List<Demographic>.from(
                json["licensors"]!.map((x) => Demographic.fromJson(x))),
        studios: json["studios"] == null
            ? []
            : List<Demographic>.from(
                json["studios"]!.map((x) => Demographic.fromJson(x))),
        genres: json["genres"] == null
            ? []
            : List<Demographic>.from(
                json["genres"]!.map((x) => Demographic.fromJson(x))),
        explicitGenres: json["explicit_genres"] == null
            ? []
            : List<dynamic>.from(json["explicit_genres"]!.map((x) => x)),
        themes: json["themes"] == null
            ? []
            : List<Demographic>.from(
                json["themes"]!.map((x) => Demographic.fromJson(x))),
        demographics: json["demographics"] == null
            ? []
            : List<Demographic>.from(
                json["demographics"]!.map((x) => Demographic.fromJson(x))),
      );
}

class Aired {
  Aired({
    this.from,
    this.to,
    this.prop,
    this.string,
  });

  DateTime? from;
  DateTime? to;
  Prop? prop;
  String? string;

  factory Aired.fromJson(Map<String, dynamic> json) => Aired(
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
        prop: json["prop"] == null ? null : Prop.fromJson(json["prop"]),
        string: json["string"],
      );
}

class Prop {
  Prop({
    this.from,
    this.to,
  });

  From? from;
  From? to;

  factory Prop.fromJson(Map<String, dynamic> json) => Prop(
        from: json["from"] == null ? null : From.fromJson(json["from"]),
        to: json["to"] == null ? null : From.fromJson(json["to"]),
      );
}

class From {
  From({
    this.day,
    this.month,
    this.year,
  });

  int? day;
  int? month;
  int? year;

  factory From.fromJson(Map<String, dynamic> json) => From(
        day: json["day"],
        month: json["month"],
        year: json["year"],
      );
}

class Broadcast {
  Broadcast({
    this.day,
    this.time,
    this.timezone,
    this.string,
  });

  String? day;
  String? time;
  String? timezone;
  String? string;

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
        day: json["day"],
        time: json["time"],
        timezone: json["timezone"],
        string: json["string"],
      );
}

class Demographic {
  Demographic({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  int? malId;
  Type? type;
  String? name;
  String? url;

  factory Demographic.fromJson(Map<String, dynamic> json) => Demographic(
        malId: json["mal_id"],
        type: json["type"],
        name: json["name"],
        url: json["url"],
      );
}

class Image {
  Image({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  String? imageUrl;
  String? smallImageUrl;
  String? largeImageUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        largeImageUrl: json["large_image_url"],
      );
}

class Title {
  Title({
    this.type,
    this.title,
  });

  String? type;
  String? title;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        type: json["type"],
        title: json["title"],
      );
}

class Trailer {
  Trailer({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  String? youtubeId;
  String? url;
  String? embedUrl;
  Images? images;

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        youtubeId: json["youtube_id"],
        url: json["url"],
        embedUrl: json["embed_url"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );
}

class Images {
  Images({
    this.imageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.maximumImageUrl,
  });

  String? imageUrl;
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;
  String? maximumImageUrl;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        mediumImageUrl: json["medium_image_url"],
        largeImageUrl: json["large_image_url"],
        maximumImageUrl: json["maximum_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "medium_image_url": mediumImageUrl,
        "large_image_url": largeImageUrl,
        "maximum_image_url": maximumImageUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
