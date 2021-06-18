import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/ADMore.dart';

class AnimeDescripation extends StatefulWidget {
  final bool topOrNot;
  final List<String> aired;
  final int episodes;
  final List<String> genres;
  final String imageUrl;
  final int malId;
  final int popularity;
  final int rank;
  final Related related;
  final double score;
  final String source;
  final String status;
  final String synopsis;
  final String title;
  final String type;

  AnimeDescripation({
    this.topOrNot = false,
    required this.malId,
    required this.aired,
    required this.episodes,
    required this.genres,
    required this.imageUrl,
    required this.popularity,
    required this.rank,
    required this.related,
    required this.score,
    required this.source,
    required this.status,
    required this.synopsis,
    required this.title,
    required this.type,
  });

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
                      return ADMore(
                        malId: _anime!.malId,
                        rank: _anime.rank,
                        title: _anime.title,
                        imageUrl: _anime.imageUrl,
                        type: _anime.type,
                        episodes: _anime.episodes,
                        aired: _anime.aired,
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
                  malId: widget.malId,
                  episodes: widget.episodes,
                  type: widget.type,
                  popularity: widget.popularity,
                  aired: widget.aired,
                  rank: widget.rank,
                  imageUrl: widget.imageUrl,
                  score: widget.score,
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
