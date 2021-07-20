import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'dart:math' as math;

class MovieDescripation extends StatefulWidget {
  final List<int> genres;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;
  final String backdropPath;
  MovieDescripation(
      {Key? key,
      required this.genres,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.backdropPath})
      : super(key: key);

  @override
  _MovieDescripationState createState() => _MovieDescripationState();
}

class _MovieDescripationState extends State<MovieDescripation> {
  Map<int, String> _genre = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Decumentry',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Sci-Fi',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western'
  };

  String _g(genre) {
    String res = '';
    for (int i = 0; i < genre.length; i++) {
      var re = _genre[genre[i]];
      res += re ?? '';
      res += ' ';
    }
    return res;
  }

  static const _actionTitles = ['Watched', 'Removed', 'Plan To Watch'];
  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        color: kPrimaryColor,
        child: Column(
          children: [
            Container(
              height: size.height * 0.30,
              width: size.width * 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/movieplaceholder.jpg'),
                  image: NetworkImage(widget.backdropPath != ' '
                      ? 'https://image.tmdb.org/t/p/w500/${widget.backdropPath}'
                      : 'https://via.placeholder.com/500'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //start, realese
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Rating
                Container(
                  child: RatingBar.builder(
                    initialRating: widget.voteAverage / 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    unratedColor: Colors.black,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                Container(
                  //Release date
                  child: Text(
                    '${widget.releaseDate.year.toString()}-${widget.releaseDate.month.toString().padLeft(2, '0')}-${widget.releaseDate.day.toString().padLeft(2, '0')}',
                    style: TextStyle(color: kSecondaryColor, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //Title
            Container(
              child: Center(
                child: SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    widget.originalTitle,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 22,
                        // fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.013),
            //Overview
            Container(
              child: SizedBox(
                width: size.width * 0.8,
                child: ExpandableText(
                  widget.overview,
                  expandText: 'show more',
                  collapseText: 'show less',
                  linkColor: kThiredColor,
                  maxLines: 6,
                  animation: true,
                  collapseOnTextTap: true,
                  style: TextStyle(
                      color: kFourthColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //Genres
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.1,
                ),
                Container(
                  child: SizedBox(
                    child: Text(
                      'Genre:',
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 19, color: kSecondaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                ),
                Container(
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      _g(widget.genres),
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 14, color: kFourthColor),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
              child: Text(
                'Recommended',
                style: TextStyle(color: kSecondaryColor, fontSize: 20),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: ExpandableFab(
      //   distance: 112.0,
      //   children: [
      //     ActionButton(
      //       onPressed: () => _showAction(context, 0),
      //       icon: const Icon(Icons.add),
      //     ),
      //     ActionButton(
      //       icon: Icon(Icons.remove),
      //       onPressed: () => _showAction(context, 1),
      //     ),
      //     ActionButton(
      //       onPressed: () => _showAction(context, 2),
      //       icon: const Icon(Icons.done),
      //     ),
      //   ],
      // ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.accentColor,
      elevation: 4.0,
      child: IconTheme.merge(
        data: theme.accentIconTheme,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
