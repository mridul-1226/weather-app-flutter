import 'package:flutter/material.dart';

class card extends StatelessWidget{

  final String time;
  final String temp;
  final IconData weatherIcon;


  card({super.key, required this.time, required this.temp, required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        margin: const EdgeInsets.only(top: 5),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(time,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25, bottom: 10),
                child: Icon(weatherIcon, size: 60,),
              ),
              Text(temp,style: const TextStyle(fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }
}