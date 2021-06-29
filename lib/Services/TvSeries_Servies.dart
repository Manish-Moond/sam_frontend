import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/TvSeries_Model.dart';

class HttpTvSeriesServices {
  Future<TvSeriesModel> getTSTrending(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/ts/trending/$page'));
    if (res.statusCode == 200) {
      TvSeriesModel result = TvSeriesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now Latest';
  }
  Future<TvSeriesModel> getTSTopRated(page) async {
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
}
