import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/TvSeries_Model.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';
import 'package:sam_frontend/Widgets/MTVS_Genres.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';
import 'package:sam_frontend/Widgets/TvSeries_Popular.dart';
import 'package:sam_frontend/Widgets/TvSeries_Top_Rated.dart';
import 'package:sam_frontend/Widgets/TvSeries_Trending.dart';
import 'package:sam_frontend/Widgets/TvSeries_Search.dart';

class TvSeriesHomePage extends StatefulWidget {
  final String searchParam;
  const TvSeriesHomePage({Key? key, required this.searchParam})
      : super(key: key);

  @override
  _TvSeriesHomePageState createState() => _TvSeriesHomePageState();
}

class _TvSeriesHomePageState extends State<TvSeriesHomePage> {
  String selected = 'All';
  final List<String> genres = [
    'Action & Adventure',
    'Comady',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Kids',
    'Mystery',
    "News",
    'Reality',
    'Sci-Fi & Fantasy',
    'Soap',
    'Talk',
    'War & Politics',
    'Western',
  ];
  void selectFunction(String newValue) {
    setState(() {
      selected = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchParam == ''
        ? Container(
            color: kPrimaryColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TvSeriesTrending(),
                    MTVSGenres(
                      selectedFunction: selectFunction,
                      selectedValue: selected,
                      genres: genres,
                    ),
                    TvSeriesGT(selected: selected),
                    TvSeriesPopular(),
                  ],
                ),
              ),
            ),
          )
        : TvSeriesSearch(
            search: widget.searchParam,
          );
  }
}

class TvSeriesGT extends StatefulWidget {
  final String selected;
  const TvSeriesGT({Key? key, required this.selected}) : super(key: key);

  @override
  _TvSeriesGTState createState() => _TvSeriesGTState();
}

class _TvSeriesGTState extends State<TvSeriesGT> {
  @override
  Widget build(BuildContext context) {
    return widget.selected == 'All'
        ? TvSeriesTopRated()
        : TvSeriesGenresResult(
            selected: widget.selected,
          );
  }
}

class TvSeriesGenresResult extends StatefulWidget {
  final String selected;
  const TvSeriesGenresResult({Key? key, required this.selected})
      : super(key: key);

  @override
  _TvSeriesGenresResultState createState() => _TvSeriesGenresResultState();
}

class _TvSeriesGenresResultState extends State<TvSeriesGenresResult> {
  final HttpTvSeriesServices _httpTvSeriesServices = HttpTvSeriesServices();
  List<Result> _movies = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  Map<String, int> _genre = {
    'Action & Adventure': 10759,
    'Comady': 35,
    'Crime': 80,
    'Documentary': 99,
    'Drama': 18,
    'Family': 10751,
    'Kids': 10762,
    'Mystery': 9648,
    'News': 10763,
    'Reality': 10764,
    'Sci-Fi & Fantasy': 10765,
    'Soap': 10766,
    'Talk': 10766,
    'War & Politics': 10768,
    'Western': 37
  };

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
    _httpTvSeriesServices
        .getTSGenreResult(page: _page, genreId: _genre[widget.selected])
        .then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpTvSeriesServices
            .getTSGenreResult(page: _page, genreId: _genre[widget.selected])
            .then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant TvSeriesGenresResult oldWidget) {
    if (this.widget.selected != oldWidget.selected) {
      _movies = [];
      _page = 1;
      _httpTvSeriesServices
          .getTSGenreResult(page: _page, genreId: _genre[widget.selected])
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: _movies.length,
            itemBuilder: (context, index) {
              return MTVCard(
                movieOrNot: false,
                genres: _movies[index].genreIds,
                id: _movies[index].id,
                originalTitle: _movies[index].name,
                originalLanguage: _movies[index].originalLanguage,
                overview: _movies[index].overview,
                backdropPath: _movies[index].backdropPath,
                posterPath: _movies[index].posterPath,
                releaseDate: _movies[index].firstAirDate,
                title: _movies[index].name,
                voteAverage: _movies[index].voteAverage,
              );
            },
          ),
        ),
      ],
    );
  }
}
