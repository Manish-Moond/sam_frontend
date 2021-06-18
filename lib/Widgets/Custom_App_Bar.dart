import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String name;
  const CustomAppBar({Key? key, required this.name}) : super(key: key);

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
              ? Text(
                  widget.name,
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
        );
      }
    }()));
  }
}
