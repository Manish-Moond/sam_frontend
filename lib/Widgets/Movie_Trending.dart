import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Models/Movie_Model.dart';
import 'package:sam_frontend/Screens/Movie_Descripetion.dart';
import 'package:sam_frontend/Services/Movie_Servies.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieTrending extends StatefulWidget {
  const MovieTrending({Key? key}) : super(key: key);

  @override
  _MovieTrendingState createState() => _MovieTrendingState();
}

class _MovieTrendingState extends State<MovieTrending> {
  final HttpMoviesServices _httpMoviesServices = HttpMoviesServices();
  List<Result> _movies = [];
  int _page = 1;

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
    _httpMoviesServices.getTrending('movie', _page).then((value) {
      filler(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          // autoPlay: true,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 1600),
        ),
        itemCount: _movies.length,
        itemBuilder: (context, index, pageViewIndex) {
          return _movies.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
              : InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MovieD(
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
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${_movies[index].backdropPath}',
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
                          _movies[index].title.toUpperCase(),
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


// FadeInImage(
//                     image: NetworkImage(
//                         'https://image.tmdb.org/t/p/original/${_movies[index].backdropPath}'),
//                     placeholder:
//                         AssetImage('assets/images/movieplaceholder.jpg'),
//                     fit: BoxFit.cover,
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width,
//                   ),


// CachedNetworkImage(
//                     imageUrl:
//                         'https://image.tmdb.org/t/p/w500/${_movies[index].posterPath}',
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width,
//                     fit: BoxFit.cover,
//                     errorWidget: (context, url, error) => Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image:
//                               AssetImage('assets/images/movieplaceholder.jpg'),
//                         ),
//                       ),
//                     ),
//                   ),