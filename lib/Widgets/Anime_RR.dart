// import 'package:flutter/material.dart';
// import 'package:sam_frontend/Constant/Colors.dart';
// import 'package:sam_frontend/Models/Anime_Model.dart';
// // import 'package:sam_frontend/Models/Anime_Model.dart';

// class RRAnime extends StatelessWidget {
//   final int malId;

//   RRAnime({Key? key, required this.malId}) : super(key: key);
//   // final HttpAnimeServices _animeServices = HttpAnimeServices();

//   @override
//   Widget build(BuildContext context) {
//     return malId == -1
//         ? Text("")
//         : Container(child: FutureBuilder(
//             // future: _animeServices.getAnime(malId: malId),
//             builder: (context, AsyncSnapshot<AnimeModel> snapshot) {
//               if (snapshot.hasData) {
//                 // AnimeModel? _anime = snapshot.data;
//                 // return AnimeCard(
//                 //   imageUrl: _anime!.imageUrl,
//                 //   malId: _anime.malId,
//                 //   rank: _anime.rank,
//                 //   title: _anime.title,
//                 //   score: _anime.score,
//                 //   episodes: _anime.episodes,
//                 //   genres: _anime.genres,
//                 //   aired: [_anime.aired[0], _anime.aired[1]],
//                 //   // related: _anime.related,
//                 //   popularity: _anime.popularity,
//                 //   status: _anime.status,
//                 // );
//               } else if (snapshot.hasError) {
//                 return Text('');
//               }
//               return Container(
//                 color: kPrimaryColor,
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: kSecondaryColor,
//                   ),
//                 ),
//               );
//             },
//           ));
//   }
// }
