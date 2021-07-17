import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/TvSeries_Model.dart';
import 'package:cron/cron.dart';

class HttpTvSeriesServices {
  Future<TvSeriesModel> getTSTrending(
      {required int page, bool isRefresh = false}) async {

    var isCacheExits =
        await APICacheManager().isAPICacheKeyExist('TvSeriesTrending');

    // Run After every 15 min and update cache
    var cron = new Cron();
    cron.schedule(new Schedule.parse('*/15 * * * *'), () async {
      final res = await http
          .get(Uri.https('sam-api-flask.herokuapp.com', '/ts/trending/$page'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'TvSeriesTrending', syncData: res.body);

        APICacheManager().addCacheData(cacheDBModel);
      }
    });


    if (!isCacheExits) {
      final res = await http
          .get(Uri.https('sam-api-flask.herokuapp.com', '/ts/trending/$page'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'TvSeriesTrending', syncData: res.body);

        APICacheManager().addCacheData(cacheDBModel);

        TvSeriesModel result = TvSeriesModel.fromJson(json.decode(res.body));
        return result;
      }
    } else {
      var cacheData = await APICacheManager().getCacheData('TvSeriesTrending');
      return TvSeriesModel.fromJson(json.decode(cacheData.syncData));
    }
    // }

    throw 'Error from now Latest';
  }

  Future<TvSeriesModel> getTSTopRated(
      {required int page, bool isRefresh = false}) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/ts/toprated/$page'));
    if (res.statusCode == 200) {
      TvSeriesModel result = TvSeriesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now Latest';
  }

  Future<TvSeriesModel> getTSPopular(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/ts/popular/$page'));
    if (res.statusCode == 200) {
      TvSeriesModel result = TvSeriesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now Latest';
  }

  Future<TvSeriesModel> getTSSearch(
      {required int page, required String name}) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/ts/search/$name/$page'));
    if (res.statusCode == 200) {
      TvSeriesModel result = TvSeriesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from search';
  }

  Future<TvSeriesModel> getTSGenreResult({page, genreId}) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/ts/genre/$genreId/$page'));
    if (res.statusCode == 200) {
      TvSeriesModel result = TvSeriesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from search';
  }
}
