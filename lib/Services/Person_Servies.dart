import 'dart:convert';

import 'package:sam_frontend/Models/Person_Info_Model.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Person_Work_Model.dart';
import 'package:sam_frontend/Models/Popular_Person_Model.dart';

class HttpPersonServices {
  Future<PersonWorkModel> getPersonWork(personId) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/person/work/$personId'));
    if (res.statusCode == 200) {
      return PersonWorkModel.fromJson(json.decode(res.body));
    }

    throw 'Error during fetching person work';
  }

  Future<PersonInfoModel> getPersonInfo(personId) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/person/info/$personId'));
    if (res.statusCode == 200) {
      return  PersonInfoModel.fromJson(json.decode(res.body));
    }

    throw 'Error during fetching person work';
  }

  Future<PopularPersonModel> getPopularPerson(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/person/popular/$page'));
    if (res.statusCode == 200) {
      return PopularPersonModel.fromJson(json.decode(res.body));
    }

    throw 'Error during fetching popular person';
  }
}
