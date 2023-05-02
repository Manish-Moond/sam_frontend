import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/anime_by_season_model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

import 'Anime_Card.dart';

class AnimeThisSeason extends StatefulWidget {
  const AnimeThisSeason({Key? key}) : super(key: key);

  @override
  _AnimeThisSeasonState createState() => _AnimeThisSeasonState();
}

class _AnimeThisSeasonState extends State<AnimeThisSeason> {
  AnimeHTTPServices _animeHTTPServices = AnimeHTTPServices();
  final ScrollController _scrollController = ScrollController();
  final List<AnimeDataList> _anime = [];
  bool _isLodingMore = false;
  bool _hasMore = true;
  int _page = 1;

  void filler(value) {
    setState(() {
      _hasMore = value.pagination.hasNextPage!;
      _anime.addAll(value.data);
      _isLodingMore = false;
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
          .getAnimeBySeason(page: _page)
          .then((value) => filler(value));
    }
  }

  @override
  void initState() {
    super.initState();
    _animeHTTPServices
        .getAnimeBySeason(page: _page)
        .then((value) => filler(value));
    _scrollController.addListener(_scrolleListener);
  }

// make genre list from List<Map>
  List<String?> _convertGenreToList(List<Demographic> genres) {
    List<String?> _gList = [];
    for (int i = 0; i < genres.length; i++) {
      _gList.add(genres[i].name);
    }
    return _gList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return _anime.isEmpty
        ? Container(
            color: kPrimaryColor,
            child: Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          )
        : Container(
            color: kPrimaryColor,
            height: 200,
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: kSecondaryColor,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: (itemWidth / itemHeight)),
                itemCount: _isLodingMore ? _anime.length + 1 : _anime.length,
                itemBuilder: (context, index) {
                  if (index < _anime.length) {
                    return AnimeCard(
                      malId: _anime[index].malId,
                      title: _anime[index].title!,
                      imageUrl: _anime[index].images!['jpg']!.imageUrl,
                      score: _anime[index].score!,
                      episodes: _anime[index].episodes!,
                      type: _anime[index].type!,
                      rank: _anime[index].rank!,
                      popularity: _anime[index].popularity!,
                      genres: _convertGenreToList(_anime[index].genres!),
                      aired: [_anime[index].aired?.string],
                      // status:  _anime.status!,
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
