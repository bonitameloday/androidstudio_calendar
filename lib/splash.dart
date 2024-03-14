import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
  const Splash({Key? key}) : super(key: key);

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>{
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              Image.asset('assets/screen.png',
                width:200,
              ),
              Text('loading...', style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initState(){
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value){
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
}