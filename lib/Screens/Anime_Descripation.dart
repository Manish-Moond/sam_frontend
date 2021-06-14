import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/ADMore.dart';

class AnimeDescripation extends StatefulWidget {
  final bool topOrNot;
  final int malId;
  final String url;
  final String imageUrl;
  final String trailerUrl;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final List<String> titleSynonyms;
  final String type;
  final String source;
  final int episodes;
  final String status;
  final bool airing;
  final Aired aired;
  final String duration;
  final String rating;
  final double score;
  final int scoredBy;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;
  final String synopsis;
  final String premiered;
  final String broadcast;
  final Related related;
  final List<Genre> producers;
  final List<Genre> licensors;
  final List<Genre> studios;
  final List<Genre> genres;

  AnimeDescripation(
      {this.topOrNot = false,
      required this.malId,
      this.url = '',
      this.imageUrl = '',
      this.trailerUrl = '',
      this.title = '',
      this.titleEnglish = '',
      this.titleJapanese = '',
      this.titleSynonyms = const [""],
      this.type = '',
      this.source = '',
      this.episodes = -1,
      this.status = '',
      this.airing = false,
      required this.aired,
      this.duration = '',
      this.rating = '',
      this.score = -1.0,
      this.scoredBy = -1,
      this.rank = -1,
      this.popularity = -1,
      this.members = -1,
      this.favorites = -1,
      this.synopsis = '',
      this.premiered = '',
      this.broadcast = '',
      required this.related,
      required this.producers,
      required this.licensors,
      required this.studios,
      required this.genres});

  @override
  _AnimeDescripationState createState() => _AnimeDescripationState();
}

class _AnimeDescripationState extends State<AnimeDescripation> {
  final HttpAnimeServices _animeServices = HttpAnimeServices();

  late Future<AnimeModel> _animeDec;
  @override
  void initState() {
    super.initState();
    _animeDec = _animeServices.getAnime(malId: widget.malId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(widget.topOrNot);
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(size),
        child: widget.topOrNot == true
            ? Container(
                child: FutureBuilder(
                  future: _animeDec,
                  builder: (context, AsyncSnapshot<AnimeModel> snapshot) {
                    if (snapshot.hasData) {
                      AnimeModel? _anime = snapshot.data;
                      print(_anime!.episodes);
                      return ADMore(
                        rank: _anime.rank,
                        title: _anime.title,
                        imageUrl: _anime.imageUrl,
                        type: _anime.type,
                        episodes: _anime.episodes,
                        startDate:
                            '${_anime.aired.prop.from.month}' + '${_anime.aired.prop.from.year}',
                        endDate: '${_anime.aired.prop.to.month}' + '${_anime.aired.prop.from.year}',
                        members: _anime.members,
                        score: _anime.score,
                        synopsis: _anime.synopsis,
                        popularity: _anime.popularity,
                        genre: _anime.genres,
                        related: _anime.related,
                      );
                    }
                    return Container(
                      color: kPrimaryColor,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              )
            : Container(
                child: ADMore(
                  episodes: widget.episodes,
                  type: widget.type,
                  popularity: widget.popularity,
                  startDate:
                      '${widget.aired.prop.from.month}' + '${widget.aired.prop.from.year}',
                  endDate:
                      '${widget.aired.prop.to.month}' + '${widget.aired.prop.from.year}',
                  rank: widget.rank,
                  imageUrl: widget.imageUrl,
                  score: widget.score,
                  members: widget.members,
                  synopsis: widget.synopsis,
                  title: widget.title,
                  genre: widget.genres,
                  related: widget.related,
                ),
              ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Size size;
  BackgroundPainter(this.size);

  @override
  void paint(Canvas canvas, Size si) {
    Paint paint1 = Paint();
    Path mainbackground = Path();
    mainbackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint1.color = kSecondaryColor;
    canvas.drawPath(mainbackground, paint1);

    final paint = Paint()
      ..color = kPrimaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    final rect = Rect.fromPoints(Offset(size.width * 0, size.height * 0.23),
        Offset(size.width * 1, size.height * 1));
    final radius = Radius.circular(32);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);

    final rect1 = Rect.fromPoints(Offset(size.width * 0, size.height * 0.8),
        Offset(size.width * 1, size.height * 1));

    canvas.drawRect(rect1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
