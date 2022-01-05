import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/screens/MainPage.dart';

import 'TransactionType/Create.dart';

class SpashPage extends StatelessWidget {
  const SpashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save Money',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/walletMoney.jpg'),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: TransactionTypeCreate() //MainPage()
        ,),
    );
  }
}