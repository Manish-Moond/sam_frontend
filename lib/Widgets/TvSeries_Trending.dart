import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Movies_Tv_Series_Model.dart';
import 'package:sam_frontend/Screens/Movie_Descripetion.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';

class TvSeriesTrending extends StatefulWidget {
  const TvSeriesTrending({Key? key}) : super(key: key);

  @override
  _TvSeriesTrendingState createState() => _TvSeriesTrendingState();
}

class _TvSeriesTrendingState extends State<TvSeriesTrending> {
  final HttpTvSeriesServices _httpTvSeriesServices = HttpTvSeriesServices();
  List<MTSResultList> _tv = [];
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
    _httpTvSeriesServices.getTSTrending(page: _page).then((value) {
      filler(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: _tv.length,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 1600),
        ),
        itemBuilder: (context, index, pageViewIndex) {
          return _loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ))
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDescripation(
                                genres: _tv[index].genreIds,
                                id: _tv[index].id,
                                originalTitle: _tv[index].title,
                                originalLanguage: _tv[index].originalLanguage,
                                overview: _tv[index].overview,
                                posterPath: _tv[index].posterPath,
                                releaseDate: _tv[index].firstAirDate,
                                title: _tv[index].name,
                                voteAverage: _tv[index].voteAverage,
                                backdropPath: _tv[index].backdropPath)));
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${_tv[index].backdropPath}',
                          placeholder: (context, url) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: kSecondaryColor,
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/movieplaceholder.jpg'),
                              ),
                            ),
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                          left: 15,
                        ),
                        child: Text(
                          _tv[index].name!.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'muli',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
