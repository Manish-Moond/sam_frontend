import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Constant/cancel_custom_icons_icons.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String name;
  final String value;
  final Function searchFillerState;
  const CustomAppBar(
      {Key? key,
      required this.name,
      required this.searchFillerState,
      required this.value})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final myController = TextEditingController();
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (() {
      if (widget.name == 'My List' || widget.name == 'More') {
        return AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Text(
            widget.name,
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        );
      } else {
        return AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: !_isSearching
              ? Row(
                  children: myController.text == ''
                      ? [
                          Text(widget.name,
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))
                        ]
                      : [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                myController.text = '';
                                widget.searchFillerState(myController.text);
                              });
                            },
                            icon: Icon(CancelCustomIcons.cancel,
                                size: 27, color: kSecondaryColor),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                          Text(
                            myController.text,
                            style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                )
              : TextField(
                  controller: myController,
                  style: TextStyle(color: kFourthColor),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kSecondaryColor)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kSecondaryColor),
                      ),
                      hintText: "${widget.name.toLowerCase()} search",
                      hintStyle: TextStyle(
                        color: kFourthColor.withOpacity(0.3),
                      )),
                ),
          actions: [
            _isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        this._isSearching = !this._isSearching;
                        widget.searchFillerState(myController.text);
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: kSecondaryColor,
                      size: 30,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        this._isSearching = !this._isSearching;
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: kSecondaryColor,
                      size: 30,
                    ))
          ],
        );
      }
    }()));
  }
}
