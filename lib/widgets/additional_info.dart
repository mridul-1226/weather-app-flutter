import 'package:flutter/material.dart';

class Info extends StatelessWidget{

  final IconData icon;
  final String title;
  final String value;


  const Info({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 60,),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(title, style: const TextStyle(fontSize: 19),),
        ),
        Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),)
      ],
    );
  }

}