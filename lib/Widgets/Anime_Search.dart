import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/Anime_Card.dart';

class AnimeSearchedByName extends StatefulWidget {
  final String search;

  const AnimeSearchedByName({Key? key, required this.search}) : super(key: key);

  @override
  _AnimeSearchedByNameState createState() => _AnimeSearchedByNameState();
}

class _AnimeSearchedByNameState extends State<AnimeSearchedByName> {
  AnimeHTTPServices _animeHTTPServices = AnimeHTTPServices();
  ScrollController _scrollController = ScrollController();
  List<AnimeDataList> _anime = [];
  bool _isLodingMore = false;
  bool _hasMore = true;
  int _page = 1;
  void filler(value) {
    setState(() {
      _hasMore = value.pagination.hasNextPage!;
      _anime.addAll(value.data);
    });
  }

  Future<void> _scrolleListener() async {
    if (!_hasMore) return;
    if (_isLodingMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLodingMore = true;
      });
      _page += 1;
      await _animeHTTPServices
          .getAnimeBySeasch(name: widget.search, page: _page)
          .then((value) => filler(value));
    }
  }

  @override
  void initState() {
    super.initState();
    _animeHTTPServices
        .getAnimeBySeasch(name: widget.search, page: _page)
        .then((value) => filler(value));
    _scrollController.addListener(_scrolleListener);
  }

  @override
  void didUpdateWidget(covariant AnimeSearchedByName oldWidget) {
    if (this.widget.search != oldWidget.search) {
      _anime = [];
      _page = 1;
      _animeHTTPServices
          .getAnimeBySeasch(name: widget.search, page: _page)
          .then((value) => filler(value));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      color: kPrimaryColor,
      child: _anime.length == 0
          ? Container(
              color: kPrimaryColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              ),
            )
          : GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: kSecondaryColor,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 2,
                ),
                controller: _scrollController,
                itemCount: _isLodingMore ? _anime.length + 1 : _anime.length,
                itemBuilder: (context, index) {
                  if (index < _anime.length) {
                    return AnimeCard(
                      malId: _anime[index].malId,
                      title: _anime[index].title!,
                      imageUrl: _anime[index].images!['jpg']!.imageUrl,
                      rank: _anime[index].rank!,
                      score: _anime[index].score!,
                      episodes: _anime[index].episodes!,
                      genres: [],
                      aired: [_anime[index].aired!.string],
                      status: '',
                      popularity: _anime[index].popularity!,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kSecondaryColor,
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}
