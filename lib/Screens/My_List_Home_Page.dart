import 'package:flutter/material.dart';

class MyListHomePage extends StatelessWidget {
  const MyListHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(
        children: [Icon(Icons.movie), Icon(Icons.ac_unit), Icon(Icons.tv)],
      ),
    );
  }
}
