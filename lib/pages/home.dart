import 'package:flutter/material.dart';
import 'package:pontodeluz/componets/app_bar.dart' as prefix0;
import 'package:pontodeluz/componets/list_item.dart';
import 'package:pontodeluz/pages/frase_do_dia.dart';
import 'package:pontodeluz/pages/oracoes.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: prefix0.appBar(context,
          title: 'Ponto de Luz', action: _actionAppBar()),
      body: Container(
        color: Color(cor.backgroundColor),
        child: _body(),
      ),
    );
  }

  _actionAppBar() {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Color(cor.fontApp),
      ),
      onSelected: (value) {
        themeSelected(value);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              value: "dia",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Dia',
                  ),
                  Icon(FontAwesomeIcons.sun),
                ],
              )),
          PopupMenuItem(
              value: "noite",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Noite'),
                  Icon(FontAwesomeIcons.moon),
                ],
              ))
        ];
      },
    );
  }

  _body() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      children: <Widget>[
        ListItem(
          title: 'Orações',
          subtitle: 'Veja aqui todas as orações',
          baseColor: cor.BASE_COLOR_1,
          icon: FontAwesomeIcons.pray,
          page: Oracoes(),
        ),
        ListItem(
          title: "Ho'ponopono",
          subtitle: 'Colocar descrição aqui...',
          baseColor: cor.BASE_COLOR_2,
          icon: FontAwesomeIcons.handHoldingHeart,
        ),
        ListItem(
          title: 'Autoestima',
          subtitle: 'Colocar descrição aqui...',
          baseColor: cor.BASE_COLOR_3,
          icon: FontAwesomeIcons.pagelines,
        ),
        ListItem(
          title: 'Meditação',
          subtitle: 'Colocar descrição aqui...',
          baseColor: cor.BASE_COLOR_1,
          icon: FontAwesomeIcons.om,
        ),
        ListItem(
          title: 'Ensinamento do dia',
          subtitle: 'Colocar descrição aqui...',
          baseColor: cor.BASE_COLOR_2,
          icon: FontAwesomeIcons.book,
          page: FraseDoDia(),
        ),
        ListItem(
          title: 'Áudios',
          subtitle: 'Colocar descrição aqui...',
          baseColor: cor.BASE_COLOR_3,
          icon: FontAwesomeIcons.headphonesAlt,
        ),
      ],
    );
  }

  themeSelected(value) {
    if (value == 'noite') {
      setState(() {
        cor.backgroundColor = cor.BACKGROUND_DARK;
        cor.backgroundItem = cor.BACKGROUND_DARK;
        cor.shadow = cor.BACKGROUND_DARK;
        cor.fontApp = cor.WHITE;
        cor.fontSubtitle = cor.WHITE400;
        cor.lightOn = false;
      });
    } else {
      setState(() {
        cor.backgroundColor = cor.BACKGROUND_LIGHT;
        cor.backgroundItem = cor.WHITE;
        cor.shadow = cor.GREY;
        cor.fontApp = cor.BLACK800;
        cor.fontSubtitle = cor.BLACK400;
        cor.lightOn = true;
      });
    }
  }
}
