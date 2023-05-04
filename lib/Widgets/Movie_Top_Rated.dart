import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movies_Tv_Series_Model.dart';
// import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';

class MovieTopRated extends StatefulWidget {
  @override
  _MovieTopRatedState createState() => _MovieTopRatedState();
}

class _MovieTopRatedState extends State<MovieTopRated> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  ScrollController _scrollController = ScrollController();
  List<MTSResultList> _movies = [];
  bool _loading = false;
  int _page = 1;

  filler(value) {
    setState(() {
      _movies.addAll(value.results);
      _loading = false;
    });
  }

  Future<void> _scrolleListener() async {
    if (_loading) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _loading = true;
      });
      _page += 1;
      await _httpMoviesServices
          .getTopMovies(page: _page)
          .then((value) => filler(value));
    }
  }

  @override
  void initState() {
    super.initState();
    _httpMoviesServices
        .getTopMovies(page: _page)
        .then((value) => filler(value));
    _scrollController.addListener(_scrolleListener);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Rated',
          style: TextStyle(
              fontSize: 18,
              color: kSecondaryColor,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: size.height * 0.011,
        ),
        Container(
          height: size.height * 0.35,
          child: _movies.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: kSecondaryColor,
                  ),
                )
              : ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.right,
                    color: kSecondaryColor,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: _loading ? _movies.length + 2 : _movies.length,
                      itemBuilder: (context, index) {
                        if (index < _movies.length) {
                          return MTVCard(
                            movieOrNot: true,
                            genres: _movies[index].genreIds!,
                            id: _movies[index].id!,
                            originalTitle: _movies[index].originalTitle!,
                            originalLanguage: _movies[index].originalLanguage!,
                            overview: _movies[index].overview!,
                            backdropPath: _movies[index].backdropPath!,
                            posterPath: _movies[index].posterPath!,
                            releaseDate: _movies[index].releaseDate!,
                            title: _movies[index].title!,
                            voteAverage: _movies[index].voteAverage!,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: kSecondaryColor,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
