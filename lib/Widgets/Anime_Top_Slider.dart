import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class AnimeTopSlider extends StatelessWidget {
  final Function animeToggler;
  final String selected;

  final List<String> _list = ['This Season', 'For You'];

  AnimeTopSlider({Key? key, required this.animeToggler, required this.selected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.03,
        color: kPrimaryColor,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ..._list.map(
              (e) => GestureDetector(
                onTap: () {
                  animeToggler(e);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Text(
                    e,
                    style: TextStyle(
                        color: e == selected ? kWhiteColor : kSecondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
