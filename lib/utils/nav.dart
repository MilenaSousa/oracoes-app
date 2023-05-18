import 'package:flutter/material.dart';

push(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

pop(context) => Navigator.pop(context);
