import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movie_Top_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Widgets/Movie_Card.dart';

class MovieTopRated extends StatelessWidget {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _httpMoviesServices.getTopMovie(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            TopRatedMoviesModel _movies = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                ..._movies.results.map((Result e) => MovieCard(
                    genres: e.genreIds,
                    id: e.id,
                    originalTitle: e.originalTitle,
                    originalLanguage: e.originalLanguage,
                    overview: e.overview,
                    posterPath: e.posterPath,
                    releaseDate: e.releaseDate,
                    title: e.title))
              ]),
            );
          }
          return Container(
            color: kPrimaryColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
