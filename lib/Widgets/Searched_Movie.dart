import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SearchedMovie extends StatefulWidget {
  const SearchedMovie({ Key? key }) : super(key: key);

  @override
  _SearchedMovieState createState() => _SearchedMovieState();
}

class _SearchedMovieState extends State<SearchedMovie> {

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print('inmovies');
      print(prefs.getString('search'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}