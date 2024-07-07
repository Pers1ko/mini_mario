import 'package:flutter/material.dart';

class MyMashrooms extends StatelessWidget {
  const MyMashrooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Image.asset('lib/images/mario_mashroom.png'),
    );
  }
}
