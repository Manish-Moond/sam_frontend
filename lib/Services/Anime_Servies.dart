import 'dart:convert';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_RR_Model.dart';
import 'package:sam_frontend/Models/Anime_Search_By_Name_Model.dart';
import 'package:sam_frontend/Models/Anime_This_Season_Model.dart';
import 'package:sam_frontend/Models/Anime_Top_Model.dart';

class HttpAnimeServices {
  Future<AnimeTopModel> getTopAnime({bool isRefresh = false}) async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist('AnimeTopAnime');

    if (isRefresh) {
      final res = await http
          .get(Uri.https('sam-api-flask.herokuapp.com', '/anime/toprated'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'AnimeTopAnime', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);

        AnimeTopModel resser = AnimeTopModel.fromJson(json.decode(res.body));
        return resser;
      }
    }

    if (!isCacheExist) {
      final res = await http
          .get(Uri.https('sam-api-flask.herokuapp.com', '/anime/toprated'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'AnimeTopAnime', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);

        AnimeTopModel resser = AnimeTopModel.fromJson(json.decode(res.body));
        return resser;
      }
    } else {
      var cacheData = await APICacheManager().getCacheData('AnimeTopAnime');
      return AnimeTopModel.fromJson(json.decode(cacheData.syncData));
    }
    throw Exception("Failed to fetch Anime");
  }

  Future<AnimeModel> getAnime({required int malId}) async {
    final res = await http
        .get(Uri.https("sam-api-flask.herokuapp.com", "anime/$malId"));
    if (res.statusCode == 200) {
      AnimeModel result = AnimeModel.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeRRModel> getRRAnime({required int malId}) async {
    final res = await http.get(Uri.https('api.jikan.moe', '/v3/anime/$malId'));
    if (res.statusCode == 200) {
      AnimeRRModel result = AnimeRRModel.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeThisSeasonModel> getThisSeason(
      {required int year,
      required String season,
      bool isRefresh = false}) async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist('AnimeThisSeason');

    if (isRefresh) {
      final res = await http.get(Uri.https(
          'sam-api-flask.herokuapp.com', '/anime/byseason/$year/$season'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'AnimeThisSeason', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);

        AnimeThisSeasonModel result =
            AnimeThisSeasonModel.fromJson(json.decode(res.body));
        return result;
      }
    }

    if (!isCacheExist) {
      final res = await http.get(Uri.https(
          'sam-api-flask.herokuapp.com', '/anime/byseason/$year/$season'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'AnimeThisSeason', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);

        AnimeThisSeasonModel result =
            AnimeThisSeasonModel.fromJson(json.decode(res.body));
        return result;
      }
    } else {
      var cacheData = await APICacheManager().getCacheData('AnimeThisSeason');
      return AnimeThisSeasonModel.fromJson(json.decode(cacheData.syncData));
    }

    throw Exception('Error');
  }

  Future<AnimeThisSeasonModel> getGenresResults(
      {required String genre,
      required int page,
      bool isRefresh = false}) async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist('AnimeGenre$genre');


    if (isRefresh) {
      final res = await http.get(Uri.https(
          'sam-api-flask.herokuapp.com', '/anime/genre/$genre/$page'));
      if (res.statusCode == 200) {
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'AnimeGenre$genre', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);

        AnimeThisSeasonModel result =
            AnimeThisSeasonModel.fromJson(json.decode(res.body));
        return result;
      }
    }

    if (!isCacheExist) {
      {
        final res = await http.get(Uri.https(
            'sam-api-flask.herokuapp.com', '/anime/genre/$genre/$page'));
        if (res.statusCode == 200) {
          APICacheDBModel cacheDBModel =
              new APICacheDBModel(key: 'AnimeGenre$genre', syncData: res.body);
          APICacheManager().addCacheData(cacheDBModel);

          AnimeThisSeasonModel result =
              AnimeThisSeasonModel.fromJson(json.decode(res.body));
          return result;
        }
      }
    } else {
      var cacheData = await APICacheManager().getCacheData('AnimeGenre$genre');
      return AnimeThisSeasonModel.fromJson(json.decode(cacheData.syncData));
    }

    throw Exception('Error');
  }

  Future<AnimeSearchByNameModel> getSearchByName(
      {required String name, required int page}) async {
    final res = await http.get(Uri.https(
        ' ', '/anime/searchByName/$name/$page'));
    if (res.statusCode == 200) {
      AnimeSearchByNameModel result =
          AnimeSearchByNameModel.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }
}
