import 'package:flutter/material.dart';
import 'package:weather_app/weather_page.dart';

void main(){
  runApp(MaterialApp(
    title: 'Weather App',
    theme: ThemeData.dark(useMaterial3: true),
    debugShowCheckedModeBanner: false,
    home: WeatherPage(),
  ));
}