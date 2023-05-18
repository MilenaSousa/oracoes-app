import 'package:flutter/cupertino.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;

baseContainer(Widget content, borderColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    decoration: BoxDecoration(
      // border: Border.all(color: cor.lightOn ? borderColor : Color(cor.WHITE),
      border: Border.all(
        color: borderColor,
        width: cor.lightOn ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Color(cor.shadow),
          blurRadius: 5.0,
          spreadRadius: 1.0,
          offset: Offset(3.0, 3.0),
        )
      ],
      color: Color(cor.backgroundItem),
    ),
    child: content,
  );
}
