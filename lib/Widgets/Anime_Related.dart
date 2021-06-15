import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

class RelatedAnime extends StatelessWidget {
  final int malId;

  RelatedAnime({Key? key, required this.malId}) : super(key: key);
  final HttpAnimeServices _animeServices = HttpAnimeServices();

  @override
  Widget build(BuildContext context) {
    print("yeee");
    return  Container(
        child: FutureBuilder(
      future: _animeServices.getAnime(malId: malId),
      builder: (context, AsyncSnapshot<AnimeModel> snapshot) {
        if (snapshot.hasData) {
          print("Yes");
          return Text('data');
        }
        return Container(
          color: kPrimaryColor,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ));
  }
}
