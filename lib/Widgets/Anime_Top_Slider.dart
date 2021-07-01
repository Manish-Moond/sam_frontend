import 'package:flutter/material.dart';

class AnimeTopSlider extends StatelessWidget {
  const AnimeTopSlider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [Text('This Season'), Text('For You')],),
    );
  }
}