import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Anime_Model.dart';

class AnimeHTTPServices {
  Future<AnimeModel> getAnimeBySeason(
      {int year = 0, String season = "", int page = 1}) async {
    if (year != 0) {
      var _isCacheExist =
          await APICacheManager().isAPICacheKeyExist('animeSeason$year$season');
      final now = DateTime.now();

      if (_isCacheExist && page == 1) {
        var cacheData =
            await APICacheManager().getCacheData('animeSeason$year$season');
        Timestamp timestampNow = Timestamp.fromDate(now);
        if (timestampNow.seconds - (cacheData.syncTime!) ~/ 1000 < 130000)
          return AnimeModelFromJson(cacheData.syncData);
      }

      final res = await http.get(Uri.parse(
          "https://api.jikan.moe/v4/seasons/$year/$season?page=$page"));
      if (res.statusCode == 200) {
        if (page == 1) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
              key: 'animeSeason$year$season', syncData: res.body);
          APICacheManager().addCacheData(cacheDBModel);
        }
        return AnimeModelFromJson(res.body);
      }
      throw Exception("Error from get anime by year and seasom");
    } else {
      var _isCacheExist =
          await APICacheManager().isAPICacheKeyExist('animeSeasonNow');
      final now = DateTime.now();

      if (_isCacheExist && page == 1) {
        var cacheData = await APICacheManager().getCacheData('animeSeasonNow');
        Timestamp timestampNow = Timestamp.fromDate(now);
        if (timestampNow.seconds - (cacheData.syncTime!) ~/ 1000 < 130000)
          return AnimeModelFromJson(cacheData.syncData);
      }

      final res = await http
          .get(Uri.parse("https://api.jikan.moe/v4/seasons/now?page=$page"));
      if (res.statusCode == 200) {
        if (page == 1) {
          APICacheDBModel cacheDBModel =
              new APICacheDBModel(key: 'animeSeasonNow', syncData: res.body);
          APICacheManager().addCacheData(cacheDBModel);
        }
        return AnimeModelFromJson(res.body);
      }
      throw Exception("Error from get anime by season now");
    }
  }

  Future<AnimeDataList> getAnime({required int malId}) async {
    final res =
        await http.get(Uri.parse("https://api.jikan.moe/v4/anime/$malId"));

    if (res.statusCode == 200) {
      return AnimeDataListFromJson(res.body);
    } else {
      throw Exception("Error");
    }
  }

  Future<AnimeModel> getAnimeTop({required int page}) async {
    var _isCacheExist = await APICacheManager().isAPICacheKeyExist('animeTop');
    final now = DateTime.now();

    if (_isCacheExist && page == 1) {
      var cacheData = await APICacheManager().getCacheData('animeTop');
      Timestamp timestampNow = Timestamp.fromDate(now);
      if (timestampNow.seconds - (cacheData.syncTime!) ~/ 1000 < 130000)
        return AnimeModelFromJson(cacheData.syncData);
    }

    final res = await http
        .get(Uri.parse("https://api.jikan.moe/v4/top/anime?page=$page"));
    if (res.statusCode == 200) {
      if (page == 1) {
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'animeTop', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);
      }
      return AnimeModelFromJson(res.body);
    } else {
      throw Exception("Error from get anime top");
    }
  }

  Future<AnimeModel> getAnimeByGenres(
      {required int genreNum, required int page}) async {
    final res = await http.get(Uri.parse(
        "https://api.jikan.moe/v4/anime?genres=$genreNum&page=$page"));
    if (res.statusCode == 200) {
      return AnimeModelFromJson(res.body);
    } else {
      throw Exception("Error");
    }
  }

  Future<AnimeModel> getAnimeBySeasch(
      {required String name, required int page}) async {
    final res = await http
        .get(Uri.parse("https://api.jikan.moe/v4/anime?letter=$name"));
    if (res.statusCode == 200) {
      return AnimeModelFromJson(res.body);
    }
    throw Exception("Error from get anime by search");
  }
}
