import 'package:flutter/material.dart';
import 'package:pontodeluz/componets/base_container.dart';
import 'package:pontodeluz/models/texto.dart';
import 'package:pontodeluz/services/oracoes_service.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:pontodeluz/utils/nav.dart';

import 'oracao.dart';

class OracoesCategoria extends StatefulWidget {
  final Map<String, dynamic> categoria;

  OracoesCategoria(this.categoria);

  @override
  _OracoesCategoriaState createState() => _OracoesCategoriaState();
}

class _OracoesCategoriaState extends State<OracoesCategoria> {
  int quantidade = 0;
  List<Texto> listaOracoes = [];
  OracoesService instanciaOracoes = OracoesService();

  get categoria => widget.categoria;

  void initState() {
    super.initState();
    getOracoesCategoria();
  }

  _txtSemFormatacao(texto) {
    var textoNaoFormatado = texto.toString().replaceAll('<p>', '');
    textoNaoFormatado = textoNaoFormatado.replaceAll('</p>', '');
    return textoNaoFormatado;
  }

  getOracoesCategoria() {
    var count = 0;
    var oracoes = instanciaOracoes.getOracoes();
    oracoes.forEach((val) {
      if(val.categNome == categoria['nome']) {
        listaOracoes.add(val);
        count+=1;
      }
    });
    setState(() { quantidade = count; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Color(cor.backgroundColor),
      child: ListView(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        children: <Widget>[
          _top(),
          _listItem(),
          SizedBox(height: 15,)
        ],
      )
    );
  }

  _top() {
    return Column(
      children: <Widget>[
        SizedBox(height: 5,),
        Text('${categoria['nome']}', style: TextStyle(
            color: Color(categoria['cor']), fontSize: 30, fontWeight: FontWeight.w600
          ), textAlign: TextAlign.center,),
          SizedBox(height: 2,),
          Text(categoria['desc'], style: TextStyle(
            color: Color(cor.fontSubtitle), fontSize: 18, 
          ), textAlign: TextAlign.center,),
          SizedBox(height: 15,),
      ],
    );
  }

  _listItem(){
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: listaOracoes.length,
      itemBuilder: (context, index) {
        if(listaOracoes[index].categNome == categoria['nome']){
          return baseContainer(
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              title: Text(listaOracoes[index].titulo, style: TextStyle(
                color: Color(cor.fontApp), 
                fontWeight: FontWeight.bold, 
                fontSize: 22,
                fontFamily: 'Nunito-Regular'
              ), overflow: TextOverflow.ellipsis, maxLines: 1,),
              subtitle: _subtitulo(listaOracoes, index),
              onTap: () {
                push(context, Oracao(oracao: listaOracoes[index]));
              },
            ),
              Color(cor.WHITE),
            );
          }
        return Container();
      },
    );
  }

  _subtitulo(listaOracoes, index) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5,),
        Text('${_txtSemFormatacao(listaOracoes[index].texto)}', 
          style: TextStyle(fontSize: 15, 
            color: Color(cor.fontSubtitle), 
            fontFamily: 'Nunito-Regular'
            // fontWeight: FontWeight
          ),
          overflow: TextOverflow.ellipsis, 
          maxLines: 2,),
          SizedBox(height: 10,),
      ],
    );
  }
}
