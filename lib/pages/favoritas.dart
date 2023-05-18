import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pontodeluz/componets/app_bar.dart';
import 'package:pontodeluz/componets/list_item_oracao.dart';
import 'package:pontodeluz/db/FavoritosDB.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:pontodeluz/models/texto.dart';

class Favoritas extends StatefulWidget {
  @override
  _FavoritasState createState() => _FavoritasState();
}

class _FavoritasState extends State<Favoritas> {
  var _stremController = StreamController();
  Future<List<Texto>> favsFuture;

  @override
  void initState() {
    super.initState();
    FavoritosDb.getInstance().getFavoritos(_stremController);
  }

  @override
  void dispose() {
    _stremController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        title: 'Orações Favoritas',
      ),
      backgroundColor: Color(cor.backgroundColor),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: <Widget>[
          _body(),
        ],
      ),
    );
  }

  _body() {
    return StreamBuilder(
      stream: _stremController.stream,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data.length > 0) {
          print(snapshot.data);
          return ListItemOracao(snapshot.data, isBackFavoritePage: true);
        }
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                '¯\\_(ツ)_/¯',
                style: TextStyle(fontSize: 21, color: Color(cor.fontApp)),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Nenhuma oração favorita no momento.',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito-Regular',
                    color: Color(cor.fontApp)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
