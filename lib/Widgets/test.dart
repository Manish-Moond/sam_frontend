import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('No', style:TextStyle(color:Colors.yellowAccent)),
    );
  }
}