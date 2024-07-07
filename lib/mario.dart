import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final nidrun;
  final size;

  const MyMario({super.key, this.direction, this.nidrun, this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return Container(
        width: size,
        height: size,
        child: nidrun
            ? Image.asset('lib/images/mario_stoit.png')
            : Image.asset('lib/images/mario_idet.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
            width: size,
            height: size,
            child: nidrun
                ? Image.asset('lib/images/mario_stoit.png')
                : Image.asset('lib/images/mario_idet.png')),
      );
    }
  }
}
