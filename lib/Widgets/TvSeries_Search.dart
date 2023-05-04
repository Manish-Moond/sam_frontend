import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movies_Tv_Series_Model.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';

class TvSeriesSearch extends StatefulWidget {
  final String search;
  const TvSeriesSearch({Key? key, required this.search}) : super(key: key);

  @override
  _TvSeriesSearchState createState() => _TvSeriesSearchState();
}

class _TvSeriesSearchState extends State<TvSeriesSearch> {
  final HttpTvSeriesServices _httpTvSeriesServices = HttpTvSeriesServices();
  List<MTSResultList> _tvseries = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _loading = true;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _tvseries.add(value.results[i]);
      }
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _httpTvSeriesServices
        .getTSSearch(name: widget.search, page: _page)
        .then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loading = true;
        _httpTvSeriesServices
            .getTSSearch(name: widget.search, page: _page)
            .then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant TvSeriesSearch oldWidget) {
    if (this.widget.search != oldWidget.search) {
      _tvseries = [];
      _page = 1;
      _loading = true;
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
      child: _loading
          ? Center(
              child: CircularProgressIndicator(
              color: kSecondaryColor,
            ))
          : ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: kSecondaryColor,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.4),
                  ),
                  controller: _scrollController,
                  itemCount: _tvseries.length,
                  itemBuilder: (context, index) {
                    return MTVCard(
                      movieOrNot: false,
                      searcedOrNot: true,
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
              ),
            ),
    );
  }
}
