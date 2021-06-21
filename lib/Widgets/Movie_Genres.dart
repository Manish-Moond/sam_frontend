import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class MovieGenres extends StatelessWidget {
   List<String> _genre = [
    'Action',
    'Drama',
    'Comady',
    'Adventure',
    'Crime ',
    'Mystery',
    'Fantasy',
    'Historical',
    'Horror',
    'Romance',
    'Satire',
    'Science fiction',
    'Thriller',
    'Western',
    'Other'
  ];
  @override
 
  Widget build(BuildContext context) {
    return Container(
      height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
      children: [
        ..._genre.map((e) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 6),
          child: Chip(label: Text(e, style: TextStyle(color: kPrimaryColor),), backgroundColor: kSecondaryColor,),
        ))
      ],
    ));
  }
}
