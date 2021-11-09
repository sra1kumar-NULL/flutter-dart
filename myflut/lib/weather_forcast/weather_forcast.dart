import 'package:flutter/material.dart';

class WeatherForcast extends StatefulWidget {
  const WeatherForcast({Key? key}) : super(key: key);

  @override
  _WeatherForcastState createState() => _WeatherForcastState();
}

class _WeatherForcastState extends State<WeatherForcast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forcast"),
      ),
    );
  }
}
