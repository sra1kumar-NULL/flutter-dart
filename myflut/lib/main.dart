import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflut/parsing_json/ParsingJsonMap.dart';
//import 'package:myflut/ui/Home.dart';
import 'package:myflut/parsing_json/ParsingJson.dart';
void main() {
  runApp(
    new MaterialApp(
      theme:ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightGreenAccent,

      ),
      home: ParsingJsonMap(),
    )
  );
}
