import 'package:flutter/material.dart';
import 'package:tracking_cuaca/pages/search_field.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchField(),
    );
  }
}



//https://api.openweathermap.org/data/2.5/weather?q=Bekasi&appid=06fa2e15d034935b90ab88feb726b0bf&units=metric