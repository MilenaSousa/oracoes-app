import 'package:flutter/material.dart';
import 'package:pontodeluz/models/texto.dart';
import 'package:pontodeluz/pages/oracao.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:pontodeluz/utils/nav.dart';

import 'base_container.dart';

class ListItemOracao extends StatelessWidget {
  final List<Texto> oracoes;
  final bool isBackFavoritePage;

  const ListItemOracao(this.oracoes, {this.isBackFavoritePage = false});

  _txtSemFormatacao(texto) {
    var textoNaoFormatado = texto.toString().replaceAll('<p>', '');
    textoNaoFormatado = textoNaoFormatado.replaceAll('</p>', '');
    return textoNaoFormatado;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(cor.backgroundColor),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: oracoes.length,
        itemBuilder: (context, index) {
          return baseContainer(
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              title: Text(
                oracoes[index].titulo,
                style: TextStyle(
                    color: Color(cor.fontApp),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Nunito-Regular'),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: _subtitulo(oracoes, index),
              onTap: () {
                push(
                    context,
                    Oracao(
                      oracao: oracoes[index],
                      isBackFavoritePage: isBackFavoritePage,
                    ));
              },
            ),
            Color(cor.WHITE),
          );
        },
      ),
    );
  }

  _subtitulo(oracoes, index) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 3,
        ),
        Text(
          '${_txtSemFormatacao(oracoes[index].texto)}',
          style: TextStyle(
              fontSize: 15,
              color: Color(cor.fontSubtitle),
              fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(
          height: 10,
        ),
        _categoria(oracoes, index),
      ],
    );
  }

  _categoria(oracoes, index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Categoria: ',
          style: TextStyle(fontSize: 15, color: Color(cor.fontApp)),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(oracoes[index].cor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Text(
            '${oracoes[index].categNome}',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        )
      ],
    );
  }
}
