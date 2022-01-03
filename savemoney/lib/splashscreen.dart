import 'package:flutter/material.dart';

import 'home.dart';


class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    //_navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(const Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "SaveMoney",)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/walletMoney.jpg')
            ),
            Container(
              child: Container(
                child: Text('Save Money',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}