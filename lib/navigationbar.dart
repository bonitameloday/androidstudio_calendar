import 'package:calendar/tree.dart';
import 'package:flutter/material.dart';

import 'diary.dart';
import 'home.dart';
import 'planner.dart';

class navigationbar extends StatefulWidget{
  const navigationbar({Key? key}) : super(key: key);

  State<navigationbar> createState() => _navigationbarState();
}

class _navigationbarState extends State<navigationbar>{
  int _selectedIndex = 0;
  final List<Widget> _pageList = [
    HomePage(),
    DiaryPage(),
    PlannerPage(),
    TreePage(),
  ];

  void clicked(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: _pageList[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '다이어리'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: '플래너'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.energy_savings_leaf),
              label: '나무'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: clicked,
      ),
    );
  }
}