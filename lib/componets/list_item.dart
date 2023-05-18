import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pontodeluz/componets/base_container.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:pontodeluz/utils/nav.dart';

class ListItem extends StatelessWidget {

  final String title;
  final String subtitle;
  final int baseColor;
  final IconData icon;
  final page;

  const ListItem({this.title, this.subtitle, this.baseColor, this.icon, this.page});

  @override
  Widget build(BuildContext context) {
    return baseContainer(
      ListTile(
        leading: Icon(icon, color: Color(baseColor), size: 30,),
        trailing: Icon(FontAwesomeIcons.chevronRight, color: Color(baseColor),),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        title: Text('$title', 
          style: TextStyle(color: Color(cor.fontApp), fontSize: 21, fontWeight: FontWeight.bold),),
          subtitle: Text('$subtitle', style: TextStyle(color: Color(cor.fontSubtitle), fontSize: 16)),
          onTap: (){
            push(context, page);
          },
      ),
      Color(cor.WHITE),
    );
  }
}