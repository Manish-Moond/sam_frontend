import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class MTVSGenres extends StatelessWidget {
  final Function selectedFunction;
  final String selectedValue;

  MTVSGenres(
      {Key? key, required this.selectedFunction, required this.selectedValue})
      : super(key: key);

  final List<String> _genre = [
    'Action',
    'Adventure',
    'Animation',
    'Comady',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Mystery',
    'Romance',
    'Science fiction',
    'TV Movie',
    'Thriller',
    'War',
    'Western',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),
        Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 6),
                  child: GestureDetector(
                    onTap: () {
                      selectedFunction('All');
                    },
                    child: Chip(
                      label: Text(
                        'All',
                        style: TextStyle(
                            color: selectedValue == 'All'
                                ? kPrimaryColor
                                : kSecondaryColor),
                      ),
                      backgroundColor: selectedValue == 'All'
                          ? kSecondaryColor
                          : kPrimaryColor,
                    ),
                  ),
                ),
                ..._genre.map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 6),
                      child: GestureDetector(
                        onTap: () {
                          selectedFunction(e);
                        },
                        child: Chip(
                          elevation: 0,
                          shadowColor: kPrimaryColor,
                          clipBehavior: Clip.antiAlias,
                          backgroundColor: selectedValue == e
                              ? kSecondaryColor
                              : kPrimaryColor,
                          label: Text(
                            e,
                            style: TextStyle(
                                color: selectedValue == e
                                    ? kPrimaryColor
                                    : kSecondaryColor),
                          ),
                        ),
                      ),
                    ))
              ],
            )),
      ],
    );
  }
}
