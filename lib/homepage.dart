import 'dart:async';

import 'package:flappybird/barriers.dart';
import 'package:flappybird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXone=1;
  double barrierXtwo=barrierXone + 1.5;


  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {

      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;

      });
      setState(() {
        if(barrierXone<-1.1){
          barrierXone+=2.2;
        }else{
          barrierXone-=0.05;
        }
      });
      setState(() {
        if(barrierXtwo<-1.1){
          barrierXtwo+=2.2;
        }else{
          barrierXtwo-=0.05;
        }
      });

      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYAxis),
                      duration: Duration(microseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                        alignment: Alignment(0, -0.3),
                        child: gameHasStarted
                            ? Text('')
                            : Text(
                                'T A P  T O  P L A Y',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.white),
                              )),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,1.1),
                      duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),),


                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 250.0,
                      ),)

                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('0',
                          style: TextStyle(color: Colors.white, fontSize: 35)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BEST',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text('10',
                          style: TextStyle(color: Colors.white, fontSize: 35)),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
