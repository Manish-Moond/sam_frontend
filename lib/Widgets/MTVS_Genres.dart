import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class MTVSGenres extends StatelessWidget {
  final Function selectedFunction;
  final String selectedValue;
  final List<String> genres;

  MTVSGenres(
      {Key? key,
      required this.selectedFunction,
      required this.selectedValue,
      required this.genres})
      : super(key: key);

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
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.right,
              color: kSecondaryColor,
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
                  ...genres.map(
                    (e) => Padding(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
