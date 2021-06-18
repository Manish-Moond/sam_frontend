import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget  {
  const CustomAppBar({ Key? key }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);

}

class _CustomAppBarState extends State<CustomAppBar> {
    var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: !_isSearching
            ? Text(
                "Anime",
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
            : TextField(
                style: TextStyle(color: kFourthColor),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kSecondaryColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryColor),
                    ),
                    hintText: "anime search",
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
                    });
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
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
      ),
    );
  }

}