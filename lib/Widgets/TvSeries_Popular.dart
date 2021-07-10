import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/TvSeries_Model.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';

class TvSeriesPopular extends StatefulWidget {
  const TvSeriesPopular({Key? key}) : super(key: key);

  @override
  _TvSeriesPopularState createState() => _TvSeriesPopularState();
}

class _TvSeriesPopularState extends State<TvSeriesPopular> {
  final HttpTvSeriesServices _httpMoviesServices = HttpTvSeriesServices();
  ScrollController _scrollController = ScrollController();

  List<Result> _tv = [];
  int _page = 1;
  bool _loading = true;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _tv.add(value.results[i]);
      }
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _httpMoviesServices.getTSPopular(_page).then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loading = true;

        _httpMoviesServices.getTSPopular(_page).then((value) {
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
          'Popular',
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
                  itemCount: _tv.length,
                  itemBuilder: (context, index) {
                    return MTVCard(
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
