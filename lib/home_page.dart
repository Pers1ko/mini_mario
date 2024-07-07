import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario/box.dart';
import 'package:mario/button.dart';
import 'package:mario/jumping_mario.dart';
import 'package:mario/mario.dart';
import 'package:mario/mashrooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double marioSize = 80;
  static double marioX = 0;
  static double marioY = 1;
  double mashroomsX = 0.5;
  double mashroomsY = 1;
  double time = 0;
  double height = 0;
  double initialHeigth = marioY;
  String direction = 'right';
  bool nidrun = false;
  bool nidjump = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
    color: Colors.white,
    fontSize: 20,
  ));
  static double boxX = -0.3;
  static double boxY = 0.3;

  void eatMashrooms() {
    if ((marioX - mashroomsX).abs() < 0.05 &&
        (marioY - mashroomsY).abs() < 0.05) {
      setState(() {
        mashroomsX = 2;
        marioSize = 110;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeigth = marioY;
  }

  void jump() {
    if (nidjump == false) {
      nidjump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeigth - height > 1) {
          nidjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeigth - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = 'right';
    eatMashrooms();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      eatMashrooms();
      if (MyButton().userHoldingButon() == true && marioX + 0.02 < 1) {
        setState(() {
          marioX += 0.02;
          nidrun = !nidrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = 'left';
    eatMashrooms();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      eatMashrooms();
      if (MyButton().userHoldingButon() == true && marioX - 0.02 > -1) {
        setState(() {
          marioX -= 0.02;
          nidrun = !nidrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  bool onBox(double x, double y) {
    if ((x - boxX).abs() < 0.05 && (y - boxY).abs() < 0.3) {
      nidjump = false;
      marioX = boxY - 0.28;
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 4,
        child: Stack(children: [
          Container(
            color: Colors.blue,
            child: AnimatedContainer(
              alignment: Alignment(marioX, marioY),
              duration: const Duration(microseconds: 0),
              child: nidjump
                  ? JumpingMArio(
                      direction: direction,
                      size: marioSize,
                    )
                  : MyMario(
                      direction: direction,
                      nidrun: nidrun,
                      size: marioSize,
                    ),
            ),
          ),
          Container(
            alignment: Alignment(boxX, boxY),
            child: MyBox(),
          ),
          Container(
            alignment: Alignment(mashroomsX, mashroomsY),
            child: const MyMashrooms(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'MARIO',
                      style: gameFont,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '0000',
                      style: gameFont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'WORLD',
                      style: gameFont,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '1-1',
                      style: gameFont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'TIME',
                      style: gameFont,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '0000',
                      style: gameFont,
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
      Container(
        height: 10,
        color: Colors.green,
      ),
      Expanded(
          flex: 1,
          child: Container(
            color: Colors.brown,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    function: moveLeft,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  MyButton(
                    function: moveRight,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                  MyButton(
                    function: jump,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  )
                ]),
          ))
    ]));
  }
}
