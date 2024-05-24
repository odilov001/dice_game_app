import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Dice Game",
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: DiceApp(),
    ),
  ));
}

class DiceApp extends StatefulWidget {
  @override
  _DiceAppState createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  var leftImage = 1;
  var rightImage = 1;
  var totalLeftImage = 0;
  var totalRightImage = 0;
  var nextPlayer = 1;
  bool canRollLeft = true;
  bool canRollRight = false;
  var winner = 1;

  void rollDice1() {
    setState(() {
      leftImage = Random().nextInt(6) + 1;
      totalLeftImage += leftImage;
      canRollLeft = false;
      canRollRight = true;
      nextPlayer = 2;

      if (totalLeftImage >= 50) {
        winner = 1;
        // print('Winner Player: $winner');
        canRollRight = false;
        canRollLeft = false;
        handleModal(context, 1);
      }
    });
  }

  void rollDice2() {
    setState(() {
      rightImage = Random().nextInt(6) + 1;
      totalRightImage += rightImage;
      canRollLeft = true;
      canRollRight = false;
      nextPlayer = 1;

      if (totalRightImage >= 50) {
        winner = 2;
        // print('Winner Player: $winner');
        canRollRight = false;
        canRollLeft = false;
        handleModal(context, 2);
      }
    });
  }

  void resetGame() {
    setState(() {
      leftImage = 1;
      rightImage = 1;
      totalLeftImage = 0;
      totalRightImage = 0;
      nextPlayer = 1;
      canRollLeft = true;
      canRollRight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "NEXT PLAYER : $nextPlayer",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: canRollLeft ? rollDice1 : null,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/dice$leftImage.png"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: canRollRight ? rollDice2 : null,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/dice$rightImage.png"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  " 1'st Player : ${totalLeftImage}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "2'nd Player: $totalRightImage",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }

  void handleModal(BuildContext context, int winner) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0),
                      child: Column(
                        children: [
                          Text("Congratulations 🎉 !",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('Player $winner is the winner!',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50.0),
                  child: ElevatedButton(
                    child: const Text(
                      '😊 NEW GAME 😊',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      resetGame();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
