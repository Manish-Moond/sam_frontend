import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movies_Tv_Series_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';

class MovieNowPlaying extends StatefulWidget {
  const MovieNowPlaying({Key? key}) : super(key: key);

  @override
  _MovieNowPlayingState createState() => _MovieNowPlayingState();
}

class _MovieNowPlayingState extends State<MovieNowPlaying> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  List<MTSResultList> _movies = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _loading = true;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _movies.add(value.results[i]);
      }
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _httpMoviesServices.getNowPlaing(_page).then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpMoviesServices.getNowPlaing(_page).then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          'Now playing',
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
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ))
              : ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.right,
                    color: kSecondaryColor,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
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
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
