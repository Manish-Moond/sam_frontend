
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Models/TvSeries_Model.dart';
import 'package:sam_frontend/Services/TvSeries_Servies.dart';

class TvSeriesTrending extends StatefulWidget {
  const TvSeriesTrending({Key? key}) : super(key: key);

  @override
  _TvSeriesTrendingState createState() => _TvSeriesTrendingState();
}

class _TvSeriesTrendingState extends State<TvSeriesTrending> {
  final HttpTvSeriesServices _httpTvSeriesServices = HttpTvSeriesServices();
  List<Result> _tv = [];
  int _page = 1;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _tv.add(value.results[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpTvSeriesServices.getTSTrending(_page).then((value) {
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
          return _tv.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
              : InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Text('data')));
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
                              CircularProgressIndicator(),
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
                          _tv[index].name.toUpperCase(),
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
