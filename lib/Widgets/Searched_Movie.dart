import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Screens/Movie_Descripetion.dart';

class SearchedMovie extends StatefulWidget {
  final String search;
  const SearchedMovie({Key? key, required this.search}) : super(key: key);

  @override
  _SearchedMovieState createState() => _SearchedMovieState();
}

class _SearchedMovieState extends State<SearchedMovie> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  List<Result> _movies = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _httpMoviesServices.getSearched(_page, widget.search).then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpMoviesServices.getSearched(_page, widget.search).then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant SearchedMovie oldWidget) {
    print('called');
    if (this.widget.search != oldWidget.search) {
      print('yes');
      _movies = [];
      _page = 1;
      _httpMoviesServices.getSearched(_page, widget.search).then((value) {
        filler(value);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _movies.add(value.results[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return SearchedMovieCard(
            genres: _movies[index].genreIds,
            id: _movies[index].id,
            originalTitle: _movies[index].originalTitle,
            originalLanguage: _movies[index].originalLanguage,
            overview: _movies[index].overview,
            backdropPath: _movies[index].backdropPath,
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

class SearchedMovieCard extends StatelessWidget {
  final List<int> genres;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;
  final String backdropPath;

  const SearchedMovieCard(
      {Key? key,
      required this.genres,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.overview,
      required this.posterPath,
      required this.backdropPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Card(
        clipBehavior: Clip.hardEdge,
        semanticContainer: true,
        color: kSecondaryColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MovieD(
                  genres: genres,
                  id: id,
                  originalTitle: originalTitle,
                  originalLanguage: originalLanguage,
                  overview: overview,
                  backdropPath: backdropPath,
                  posterPath: posterPath,
                  releaseDate: releaseDate,
                  title: title,
                  voteAverage: voteAverage,
                ),
              ),
            );
          },
          child: Row(
            children: [
              //Image
              Column(
                children: [
                  Container(
                    height: size.height * 0.20,
                    width: size.width * 0.27,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/movieplaceholder.jpg'),
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/$posterPath'),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              //About Movie
              Column(
                children: [
                  SizedBox(
                    width: size.width * 0.65,
                    child: Text(
                      title,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: kPrimaryColor, fontSize: 15),
                    ),
                  ),
                  Container(
                    child: RatingBar.builder(
                      initialRating: voteAverage / 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      unratedColor: Colors.white,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: kPrimaryColor,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
