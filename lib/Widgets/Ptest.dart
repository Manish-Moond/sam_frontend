import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Movie_Top_Model.dart';

class Ptest extends StatefulWidget {
  const Ptest({Key? key}) : super(key: key);

  @override
  _PtestState createState() => _PtestState();
}

class _PtestState extends State<Ptest> {
  List<String> images = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetch(1);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetch(2);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 226,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
                'https://image.tmdb.org/t/p/w500/${images[index]}');
          }),
    );
  }

  fetch(page) async {
    final res =
        await http.get(Uri.http("192.168.43.19:8089", "/topmovie/$page"));
    if (res.statusCode == 200) {
      TopRatedMoviesModel result =
          TopRatedMoviesModel.fromJson(json.decode(res.body));
      setState(() {
        for (int i = 0; i < 10; i++) {
          images.add(result.results[i].posterPath);
        }
      });
    }
  }
}
