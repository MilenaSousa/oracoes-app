import 'package:flutter/material.dart';
import 'package:pontodeluz/componets/app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pontodeluz/db/FavoritosDB.dart';
import 'package:pontodeluz/pages/favoritas.dart';
import 'package:share/share.dart';
import 'package:pontodeluz/models/texto.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class Oracao extends StatefulWidget {
  final Texto oracao;
  // vou usar essa condição para verificar se o botao de voltar esta voltando
  // para a página de favoritos, caso sim eu irei fazer um refresh para atualizar os favs
  // para garantir que caso ele desfavorite, seja atualizado na hora
  final bool isBackFavoritePage;

  Oracao({this.oracao, this.isBackFavoritePage = false});

  @override
  _OracaoState createState() => _OracaoState();
}

class _OracaoState extends State<Oracao> {
  final double paragrafo = 20.0;
  final double fontSize = 16.0;
  final String fontFamily = 'Nunito-Regular';
  bool isFavorite = false;

  get oracao => widget.oracao;

  onPressFavorite() async {
    final db = FavoritosDb.getInstance();
    final exists = await db.exists(widget.oracao);

    if (exists) {
      db.deleteFavorito(widget.oracao.id);
    } else {
      await db.saveFav(widget.oracao);
    }

    setState(() {
      isFavorite = !exists;
    });
  }

  _txtSemFormatacao(texto) {
    var textoNaoFormatado = texto.toString().replaceAll('<p>', '');
    textoNaoFormatado = textoNaoFormatado.replaceAll('</p>', '');
    return textoNaoFormatado;
  }

  onPressShare() async {
    var txt = _txtSemFormatacao(oracao.texto);
    await Share.share(
        '$txt \n\nOração do app Ponto de Luz 🙏. Baixe agora para Android e IOS 📲');
  }

  @override
  void initState() {
    super.initState();
    FavoritosDb.getInstance().exists(oracao).then((b) {
      setState(() {
        isFavorite = b;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context,
            action: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red[300] : Colors.grey[600],
                size: 28,
              ),
              onPressed: () {
                onPressFavorite();
              },
            ),
            backAction: widget.isBackFavoritePage
                ? () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => Favoritas(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 1),
                      ),
                    );
                  }
                : null),
        backgroundColor: Color(cor.backgroundColor),
        body: ListView(
          children: <Widget>[
            Container(
              height: 230,
              child: SizedBox.expand(
                child: Image.asset(widget.oracao.categImg, fit: BoxFit.cover),
              ),
            ),
            _body(),
          ],
        ));
  }

  _body() {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(oracao.titulo,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Color(cor.fontApp))),
                  SizedBox(
                    height: 3,
                  ),
                  GestureDetector(
                    child: Text(
                      oracao.fonte,
                      style: TextStyle(
                          color: Color(cor.fontSubtitle), fontSize: 13),
                    ),
                    onTap: () {
                      launch(oracao.fonte); // link
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.shareAlt,
                  color: Color(cor.fontApp),
                ),
                onPressed: () {
                  onPressShare();
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Divider(
            color: Color(cor.fontSubtitle),
          ),
        ),
        Html(
          data: """${oracao.texto}""",
          customTextStyle: (dom.Node node, TextStyle baseStyle) {
            if (node is dom.Element) {
              switch (node.localName) {
                case "p":
                  return baseStyle.merge(TextStyle(
                      fontSize: 18,
                      fontFamily: fontFamily,
                      color: Color(cor.fontApp)));
                case "b":
                  return baseStyle
                      .merge(TextStyle(fontWeight: FontWeight.bold));
              }
            }
            return baseStyle;
          },
        ),
      ],
    );
  }
}
