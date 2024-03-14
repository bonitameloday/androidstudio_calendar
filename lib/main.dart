import 'dart:async';
import 'package:calendar/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar/home.dart';
import 'package:calendar/navigationbar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() async{
  runApp(MyApp());
  DependencyInjectuon.init();
}

class MyApp extends StatelessWidget{

  Widget build(BuildContext context){
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      title: 'calendar',
      home: navigationbar(),
    );
  }
}