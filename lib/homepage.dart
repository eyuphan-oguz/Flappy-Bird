import 'package:flappybird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYAxis=0;

  void jump(){
    setState(() {
      birdYAxis-=0.1;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: jump,
                child: AnimatedContainer(
                  alignment: Alignment(1,birdYAxis),
                  duration: Duration(microseconds: 0),
                  color: Colors.blue,child: MyBird(),),
              ),),
          Expanded(child: Container(color: Colors.green,)),
        ],
      ),
    );
  }
}
