import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pontodeluz/componets/custom_switch.dart';
import 'package:pontodeluz/componets/list_item_oracao.dart';
import 'package:pontodeluz/pages/oracao.dart';
import 'package:pontodeluz/services/oracoes_service.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:pontodeluz/utils/nav.dart';
import 'package:pontodeluz/utils/themes.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favoritas.dart';

class Oracoes extends StatefulWidget {
  @override
  _OracoesState createState() => _OracoesState();
}

class _OracoesState extends State<Oracoes> {
  OracoesService instOracoes = OracoesService();
  SharedPreferences prefs;
  bool _onOff; // tema do app - light/dark
  bool todasOrac = true;
  var oracoesCateg;
  var todasOracoes;
  var categ;

  @override
  void initState() {
    todasOracoes = instOracoes.getOracoes();
    categ = instOracoes.getCategorias();
    _checkTheme();
    super.initState();
  }

  _checkTheme() async {
    prefs = await SharedPreferences.getInstance();
    _onOff = prefs.getBool('themeOption');
    print(_onOff);
    setState(() {
      if (_onOff == null) {
        _onOff = true;
      } else if (_onOff == true) {
        themeLight();
      } else {
        themeDark();
      }
    });
  }

  _onPressOracao(oracao, context) {
    Navigator.pop(context);
    push(context, Oracao(oracao: oracao));
  }

  _oracoesAleatorias() {
    Navigator.pop(context); // desce o menuBottom
    var numMaximo = todasOracoes.length;
    var random = new Random();
    var numAleat = random.nextInt(numMaximo);

    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: 180,
                decoration: BoxDecoration(
                  color: Color(cor.backgroundColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset.zero,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // SizedBox(height: 30),
                    Text(
                      'Oração Escolhida',
                      style: TextStyle(
                          color: Color(cor.fontApp),
                          fontSize: 16,
                          fontFamily: 'Nunito-Regular'),
                    ),
                    Text(
                      '${todasOracoes[numAleat].titulo}',
                      style: TextStyle(
                          color: Color(cor.fontSubtitle),
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito-Regular'),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Divider(
                            color: Color(cor.fontApp),
                          ),
                          Icon(
                            FontAwesomeIcons.eye,
                            color: Color(cor.fontSubtitle),
                            size: 32,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'LER',
                            style: TextStyle(
                                color: Color(cor.fontSubtitle),
                                fontFamily: 'Nunito-Regular'),
                          )
                        ],
                      ),
                      onTap: () {
                        _onPressOracao(todasOracoes[numAleat], context);
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  _oracoesFavoritas() {
    Navigator.pop(context);
    push(context, Favoritas());
  }

  themeSelected(value, setStateT) {
    if (value) {
      // light
      setStateT(() {
        setState(() {
          themeLight();
          _onOff = !_onOff;
        });
      });
    } else {
      // dark
      setStateT(() {
        setState(() {
          themeDark();
          _onOff = !_onOff;
        });
      });
    }
    prefs.setBool('themeOption', value);
  }

  @override
  Widget build(BuildContext context) {
    menuBottom() {
      menuItem(label, onPress) => InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Nunito-Regular',
                  fontSize: 18,
                  color: Color(cor.fontApp),
                ),
              ),
            ),
            onTap: onPress,
          );

      return showRoundedModalBottomSheet(
          radius: 20.0,
          context: context,
          autoResize: false,
          dismissOnTap: false,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateT) {
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color(cor.backgroundColor),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        menuItem('Orações Favoritas', _oracoesFavoritas),
                        menuItem('Oração aleatória', _oracoesAleatorias),
                        menuItem('Contato', () {}),
                        CustomSwitch(
                            onChange: themeSelected,
                            setStateT: setStateT,
                            switchControl: _onOff),
                      ],
                    ));
              },
            );
          });
    }

    _categoria(label, color) {
      return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.fromLTRB(4, 5, 4, 10),
          decoration: BoxDecoration(
              border: Border.all(color: Color(color), width: 2),
              color: Color(cor.backgroundColor),
              borderRadius: BorderRadius.circular(10)),
          child: Text(label, style: TextStyle(color: Color(cor.fontApp))),
        ),
        onTap: () {
          if (label == "Todas") {
            setState(() {
              todasOrac = true;
            });
          } else {
            setState(() {
              todasOrac = false;
              oracoesCateg = instOracoes.getOracoesCateg(label);
            });
          }
        },
      );
    }

    _categorias() {
      return Container(
        color: Color(cor.backgroundColor),
        margin: EdgeInsets.only(top: 18, bottom: 5),
        height: 45,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              _categoria('Todas', 0xff7E7E7E),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemCount: categ.length,
                  itemBuilder: (context, index) {
                    return _categoria(
                        categ[index]["nome"], categ[index]["cor"]);
                  }),
              SizedBox(
                width: 4,
              ),
            ],
          ),
        ),
      );
    }

    _body() {
      return Container(
          color: Color(cor.backgroundColor),
          child: ListView(
            children: <Widget>[
              _categorias(),
              ListItemOracao(todasOrac ? todasOracoes : oracoesCateg),
              SizedBox(height: 10),
            ],
          ));
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: cor.lightOn
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        elevation: 1,
        iconTheme: new IconThemeData(color: Color(cor.fontApp)),
        backgroundColor: Color(cor.backgroundColor),
        centerTitle: false,
        leading: Container(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/lotus-flower.png',
              color: Color(cor.fontApp),
              width: 25,
            ),
            SizedBox(width: 12),
            Text(
              'PONTO DE LUZ',
              style: TextStyle(
                  color: Color(cor.fontApp),
                  fontSize: 18,
                  fontFamily: 'Nunito-Regular'),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: menuBottom,
          ),
        ],
      ),
      body: _body(),
    );
  }
}
