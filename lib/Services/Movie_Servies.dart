import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cron/cron.dart';

class HttpMoviesServices {
  Future<MoviesModel> getTrending(type, page) async {
    var isCacheExits =
        await APICacheManager().isAPICacheKeyExist('MovieTrending');

    // Run After every 15 min and update cache
    var cron = new Cron();
    cron.schedule(new Schedule.parse('*/15 * * * *'), () async {
      final res = await http.get(Uri.https(
          'sam-api-flask.herokuapp.com', '/movie/trending/$type/$page'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'MovieTrending', syncData: res.body);

        APICacheManager().addCacheData(cacheDBModel);
      }
    });

    if (!isCacheExits) {
      final res = await http.get(Uri.https(
          'sam-api-flask.herokuapp.com', '/movie/trending/$type/$page'));
      if (res.statusCode == 200) {
        // Adding data to local DB for performance
        APICacheDBModel cacheDBModel =
            new APICacheDBModel(key: 'MovieTrending', syncData: res.body);

        APICacheManager().addCacheData(cacheDBModel);

        MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
        return result;
      }
    } else {
      var cacheData = await APICacheManager().getCacheData('MovieTrending');
      return MoviesModel.fromJson(json.decode(cacheData.syncData));
    }

    throw 'Error from Trandin Movies';
  }

  Future<MoviesModel> getGenresMovies(genresId, page) async {
    final res = await http.get(Uri.https(
        'sam-api-flask.herokuapp.com', '/movie/genre/$genresId/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now Latest';
  }

  Future<MoviesModel> getTopMovie(page) async {
    final res = await http
        .get(Uri.https("sam-api-flask.herokuapp.com", "/movie/toprated/$page"));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error during fetching top movies';
  }

  Future<MoviesModel> getNowPlaing(page) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/movie/nowplaying/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now playing';
  }

  Future<MoviesModel> getPopular(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/movie/popular/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from POPULAR movies';
  }

  Future<MoviesModel> getSearched(page, search) async {
    final res = await http.get(Uri.https(
        'sam-api-flask.herokuapp.com', '/movie/search/$search/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    // ignore: todo
    // TODO: handle proper error when there is no movie for given name
    throw 'Error from searched';
  }
}
