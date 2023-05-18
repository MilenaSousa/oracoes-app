import 'package:flutter/material.dart';
import 'package:pontodeluz/pages/home.dart';
import 'package:pontodeluz/pages/oracoes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.grey),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Oracoes(),
    );
  }
}
