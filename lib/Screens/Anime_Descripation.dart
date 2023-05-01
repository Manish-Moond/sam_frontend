// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/ADMore.dart';

class AnimeDescripation extends StatelessWidget {
  final List<String?>? aired;
  final int episodes;
  final List<String?> genres;
  final String imageUrl;
  final int? malId;
  final int popularity;
  final int rank;
  final double score;
  final String source;
  final String status;
  final String synopsis;
  final String title;
  final String type;

  AnimeDescripation({
    Key? key,
    this.aired,
    required this.episodes,
    required this.genres,
    required this.imageUrl,
    this.malId = 0,
    required this.popularity,
    required this.rank,
    required this.score,
    required this.source,
    required this.status,
    required this.synopsis,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(size),
        child: Container(
          child: ADMore(
            malId: malId,
            episodes: episodes,
            type: type,
            popularity: popularity,
            aired: aired!,
            rank: rank,
            imageUrl: imageUrl,
            score: score,
            synopsis: synopsis,
            title: title,
            genre: genres,
            // related: widget.related,
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
