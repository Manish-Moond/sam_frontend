import 'dart:convert';

import 'package:sam_frontend/Models/Person_Info_Model.dart';
import 'package:sam_frontend/Models/Person_Model.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Popular_Person_Model.dart';

class HttpPersonServices {
  Future<PersonWorkModel> getPersonWork(personId) async {
    final res = await http.get(Uri.https('api.themoviedb.org',
        '/3/person/$personId/movie_credits?api_key=0e629947ca4ce096d9e1872727f224c1&language=en-US'));

    if (res.statusCode == 200) {
      print('persinmodel called');
      PersonWorkModel result = PersonWorkModel.fromJson(json.decode(res.body));
      print('person model done');
      return result;
    }

    throw 'Error during fetching person work';
  }

  Future<PersonInfoModel> getPersonInfo(personId) async {
    final res = await http.get(Uri.https('api.themoviedb.org',
        '/3/person/$personId?api_key=0e629947ca4ce096d9e1872727f224c1&language=en-US'));

    if (res.statusCode == 200) {
      print('person info called');
      PersonInfoModel result = PersonInfoModel.fromJson(json.decode(res.body));
      print('person info done');
      return result;
    }

    throw 'Error during fetching person work';
  }

  Future<PopularPersonModel> getPopularPerson(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/popular/person/$page'));
    if (res.statusCode == 200) {
      return PopularPersonModel.fromJson(json.decode(res.body));
    }

    throw 'Error during fetching person work';
  }
}
