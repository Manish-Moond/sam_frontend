import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';

class MovieSearch extends StatefulWidget {
  final String search;
  const MovieSearch({Key? key, required this.search}) : super(key: key);

  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  List<Result> _movies = [];
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
    _loading = true;
    _httpMoviesServices.getSearched(_page, widget.search).then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loading = true;
        _httpMoviesServices.getSearched(_page, widget.search).then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant MovieSearch oldWidget) {
    if (this.widget.search != oldWidget.search) {
      _movies = [];
      _page = 1;
      _loading = true;
      _httpMoviesServices.getSearched(_page, widget.search).then((value) {
        filler(value);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
            color: kPrimaryColor,
            child: Center(
                child: CircularProgressIndicator(
              color: kSecondaryColor,
            )),
          );
    } else {
      return Container(
            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
            color: kPrimaryColor,
            child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                color: kSecondaryColor,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.4),
                  ),
                  controller: _scrollController,
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    return MTVCard(
                      movieOrNot: true,
                      searcedOrNot: true,
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
              ),
            ),
          );
    }
  }
}
