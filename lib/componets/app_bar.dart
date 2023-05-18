import 'package:flutter/material.dart';
import 'package:pontodeluz/utils/constants.dart';

appBar(context, {String title = '', action, backAction}) {
  return AppBar(
    brightness: lightOn ? Brightness.light : Brightness.dark,
    automaticallyImplyLeading: false,
    title: Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 10),
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: backAction ??
                () {
                  Navigator.pop(context);
                },
          ),
          Text(
            title,
            style: TextStyle(
                color: Color(fontApp),
                fontSize: 21,
                fontFamily: 'Nunito-Regular'),
          ),
        ],
      ),
    ),
    titleSpacing: 0,
    backgroundColor: Color(backgroundColor),
    actions: <Widget>[action ?? Container()],
  );
}
