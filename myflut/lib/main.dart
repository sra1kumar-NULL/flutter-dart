import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflut/board_firestore/board_app.dart';
import 'package:myflut/weather_forcast/weather_forcast.dart';
import 'package:myflut/parsing_json/ParsingJsonMap.dart';
import 'package:myflut/ui/Home.dart';
// import 'package:maps/maps.dart';
import 'package:myflut/parsing_json/ParsingJson.dart';
import 'package:myflut/weather_forcast/weather_forcast.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: BoardApp(),
  ));
}
// void main() {
//   runApp(
//     new MaterialApp(
//       theme:ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.lightGreenAccent,
//
//       ),
//       home: BoardApp(),
//     )
//   );
// }
