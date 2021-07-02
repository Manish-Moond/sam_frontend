import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/TvSeries_Model.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';
import 'package:sam_frontend/Widgets/Movie_Card.dart';

class TvSeriesTopRated extends StatefulWidget {
  @override
  _TvSeriesTopRatedState createState() => _TvSeriesTopRatedState();
}

class _TvSeriesTopRatedState extends State<TvSeriesTopRated> {
  final HttpTvSeriesServices _httpTvSeriesServices = HttpTvSeriesServices();
  List<Result> _tv = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _tv.add(value.results[i]);
      }
      // execute when count of movie or tvseries is less then 10
      if (value.results.length < 10) {
        _page += 1;
        _httpTvSeriesServices
            .getTSTopRated(_page)
            .then((value) => filler(value));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpTvSeriesServices.getTSTopRated(_page).then((value) {
      filler(value);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpTvSeriesServices.getTSTopRated(_page).then((value) {
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: _tv.length,
            itemBuilder: (context, index) {
              return MovieCard(
                genres: _tv[index].genreIds,
                id: _tv[index].id,
                originalTitle: _tv[index].name,
                originalLanguage: _tv[index].originalLanguage,
                overview: _tv[index].overview,
                backdropPath: _tv[index].backdropPath,
                posterPath: _tv[index].posterPath,
                releaseDate: _tv[index].firstAirDate,
                title: _tv[index].name,
                voteAverage: _tv[index].voteAverage,
              );
            },
          ),
        ),
      ],
    );
  }
}
