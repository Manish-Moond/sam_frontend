import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';
import 'package:sam_frontend/Widgets/MTVS_Genres.dart';
import 'package:sam_frontend/Widgets/Movie_Trending.dart';
import 'package:sam_frontend/Widgets/Movie_Now_Playing.dart';
import 'package:sam_frontend/Widgets/Movie_Top_Rated.dart';
import 'package:sam_frontend/Widgets/Movie_Search.dart';

class MovieHomePage extends StatefulWidget {
  final String searchParam;
  const MovieHomePage({Key? key, required this.searchParam}) : super(key: key);

  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  String selected = 'All';
  final List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Comady',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Mystery',
    'Romance',
    'Science fiction',
    'TV Movie',
    'Thriller',
    'War',
    'Western',
  ];
  void selectFunction(String newValue) {
    if (mounted) {
      setState(() {
        selected = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchParam == ''
        ? Container(
            color: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieTrending(),
                    MTVSGenres(
                        genres: genres,
                        selectedFunction: selectFunction,
                        selectedValue: selected),
                    MovieGT(selected: selected),
                    MovieNowPlaying(),
                    // MoviePopular(),
                  ],
                ),
              ),
            ))
        : MovieSearch(search: widget.searchParam);
  }
}

class MovieGT extends StatefulWidget {
  final String selected;
  const MovieGT({Key? key, required this.selected}) : super(key: key);

  @override
  _MovieGTState createState() => _MovieGTState();
}

class _MovieGTState extends State<MovieGT> {
  @override
  Widget build(BuildContext context) {
    return widget.selected == 'All'
        ? MovieTopRated()
        : MGenreMovies(
            selected: widget.selected,
          );
  }
}

class MGenreMovies extends StatefulWidget {
  final String selected;
  const MGenreMovies({Key? key, required this.selected}) : super(key: key);

  @override
  _MGenreMoviesState createState() => _MGenreMoviesState();
}

class _MGenreMoviesState extends State<MGenreMovies> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  List<Result> _movies = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _loading = true;
  Map<String, int> _genre = {
    'Action': 28,
    'Adventure': 12,
    'Animation': 16,
    'Comady': 35,
    'Crime': 80,
    'Documentary': 99,
    'Drama': 18,
    'Family': 10751,
    'Fantasy': 14,
    'History': 36,
    'Horror': 27,
    'Music': 10402,
    'Mystery': 9648,
    'Romance': 10749,
    'Science fiction': 878,
    'TV Movie': 10770,
    'Thriller': 53,
    'War': 10752,
    'Western': 37
  };

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
    _httpMoviesServices
        .getGenresMovies(_genre[widget.selected], _page)
        .then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loading = true;
        _httpMoviesServices
            .getGenresMovies(_genre[widget.selected], _page)
            .then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant MGenreMovies oldWidget) {
    if (this.widget.selected != oldWidget.selected) {
      _movies = [];
      _page = 1;
      _loading = true;
      _httpMoviesServices
          .getGenresMovies(_genre[widget.selected], _page)
          .then((value) => filler(value));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.selected,
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
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    return MTVCard(
                      movieOrNot: true,
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
      ],
    );
  }
}
