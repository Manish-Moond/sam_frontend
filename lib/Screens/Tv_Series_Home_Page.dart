import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/MTVS_Genres.dart';
import 'package:sam_frontend/Widgets/TvSeries_Popular.dart';
import 'package:sam_frontend/Widgets/TvSeries_Top_Rated.dart';
import 'package:sam_frontend/Widgets/TvSeries_Trending.dart';

class TvSeriesHomePage extends StatefulWidget {
  final String searchParam;
  const TvSeriesHomePage({Key? key, required this.searchParam})
      : super(key: key);

  @override
  _TvSeriesHomePageState createState() => _TvSeriesHomePageState();
}

class _TvSeriesHomePageState extends State<TvSeriesHomePage> {
  String selected = 'All';
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
                        selectedValue: selected),
                    TvSeriesTopRated(),
                    TvSeriesPopular(),
                  ],
                ),
              ),
            ),
          )
        : Text('data');
  }
}
