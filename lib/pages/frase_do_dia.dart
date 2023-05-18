import 'package:flutter/material.dart';
import 'package:pontodeluz/utils/constants.dart' as cor;
import 'package:pontodeluz/componets/app_bar.dart';

class FraseDoDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: ''),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        color: Color(cor.backgroundColor),
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('O segredo para ser feliz é aceitar o '
        'lugar onde você está hoje na vida, e dar o melhor de si todos os dias.',
        style: TextStyle(
          color: Color(cor.fontApp), 
          fontFamily: 'Nunito-Regular', 
          fontSize: 16.5,
          ),),
        SizedBox(height: 30,),
        Text('18/06', style: TextStyle(color: Color(cor.fontApp),),)
      ],
    );
  }
}