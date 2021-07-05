import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/TvSeries_Model.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';
import 'package:sam_frontend/Widgets/Movie_Card.dart';

class TvSearchByName extends StatefulWidget {
  final String search;
  const TvSearchByName({Key? key, required this.search}) : super(key: key);

  @override
  _TvSearchByNameState createState() => _TvSearchByNameState();
}

class _TvSearchByNameState extends State<TvSearchByName> {
  final HttpTvSeriesServices _httpTvSeriesServices = HttpTvSeriesServices();
  List<Result> _tvseries = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _tvseries.add(value.results[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpTvSeriesServices
        .getTSSearch(name: widget.search, page: _page)
        .then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpTvSeriesServices
            .getTSSearch(name: widget.search, page: _page)
            .then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant TvSearchByName oldWidget) {
    if (this.widget.search != oldWidget.search) {
      _tvseries = [];
      _page = 1;
      _httpTvSeriesServices
          .getTSSearch(page: _page, name: widget.search)
          .then((value) => filler(value));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.4),
        ),
        controller: _scrollController,
        itemCount: _tvseries.length,
        itemBuilder: (context, index) {
          return MovieCard(
            genres: _tvseries[index].genreIds,
            id: _tvseries[index].id,
            originalTitle: _tvseries[index].name,
            originalLanguage: _tvseries[index].originalLanguage,
            overview: _tvseries[index].overview,
            backdropPath: _tvseries[index].backdropPath,
            posterPath: _tvseries[index].posterPath,
            releaseDate: _tvseries[index].firstAirDate,
            title: _tvseries[index].name,
            voteAverage: _tvseries[index].voteAverage,
          );
        },
      ),
    );
  }
}
