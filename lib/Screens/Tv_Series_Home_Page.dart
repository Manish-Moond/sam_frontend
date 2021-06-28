import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class TvSeriesHomePage extends StatelessWidget {
  final String searchParam;
  const TvSeriesHomePage({Key? key, required this.searchParam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return searchParam == ''
        ? Container(
            color: kPrimaryColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                ],
              ),
            ),
          )
        : Text('data');
  }
}
