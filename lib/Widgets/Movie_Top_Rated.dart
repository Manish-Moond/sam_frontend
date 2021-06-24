import 'package:flutter/material.dart';
import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Widgets/Movie_Card.dart';

class MovieTopRated extends StatefulWidget {
  @override
  _MovieTopRatedState createState() => _MovieTopRatedState();
}

class _MovieTopRatedState extends State<MovieTopRated> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  List<Result> _movies = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _movies.add(value.results[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpMoviesServices.getTopMovie(_page).then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpMoviesServices.getTopMovie(_page).then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 226,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return MovieCard(
              genres: _movies[index].genreIds,
              id: _movies[index].id,
              originalTitle: _movies[index].originalTitle,
              originalLanguage: _movies[index].originalLanguage,
              overview: _movies[index].overview,
              posterPath: _movies[index].posterPath,
              releaseDate: _movies[index].releaseDate,
              title: _movies[index].title,
              voteAverage: _movies[index].voteAverage,
          );
        },
      ),
    );
  }
}
