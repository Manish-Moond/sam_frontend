import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Constant/api_key.dart';
import 'package:sam_frontend/Models/Movies_Tv_Series_Model.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class HttpTvSeriesServices {
  Future<MoviesTvSeriesModel> getTSTrending({required int page}) async {
    var _isCacheExist =
        await APICacheManager().isAPICacheKeyExist('trendingTv');

    if (_isCacheExist && page == 1) {
      var cacheData = await APICacheManager().getCacheData('trendingTv');
      Timestamp timestampNow = Timestamp.fromDate(DateTime.now());
      if (timestampNow.seconds - (cacheData.syncTime!) ~/ 1000 < 1000)
        return moviesTvSeriesModelFromJson(cacheData.syncData);
    }

    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/tv/day?api_key=$tbdbApiKey&page=1"));
    if (res.statusCode == 200) {
      if (page == 1) {
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'trendingTv', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);
      }

      return moviesTvSeriesModelFromJson(res.body);
    }
    throw Exception("Error from TS trending");
  }

  Future<MoviesTvSeriesModel> getTSTopRated(
      {required int page, bool isRefresh = false}) async {
    var _isCacheExist =
        await APICacheManager().isAPICacheKeyExist('topRatedTv');

    if (_isCacheExist && page == 1) {
      var cacheData = await APICacheManager().getCacheData('topRatedTv');
      Timestamp timestampNow = Timestamp.fromDate(DateTime.now());
      if (timestampNow.seconds - (cacheData.syncTime!) ~/ 1000 < 1000)
        return moviesTvSeriesModelFromJson(cacheData.syncData);
    }

    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/top_rated?api_key=$tbdbApiKey&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      if (page == 1) {
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'topRatedTv', syncData: res.body);
        APICacheManager().addCacheData(cacheDBModel);
      }

      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from now Latest';
  }

  Future<MoviesTvSeriesModel> getTSPopular(page) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/popular?api_key=$tbdbApiKey&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from now Latest';
  }

  Future<MoviesTvSeriesModel> getTSSearch(
      {required int page, required String name}) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/tv?api_key=$tbdbApiKey&language=en-US&query=$name&page=$page"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from search';
  }

  Future<MoviesTvSeriesModel> getTSGenreResult({page, genreId}) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/tv?api_key=$tbdbApiKey&page=$page&with_genres=$genreId"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from search';
  }
}
