import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar/home.dart';
import 'package:calendar/diary.dart';
import 'package:calendar/planner.dart';
import 'package:calendar/tree.dart';
import 'edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'DataModel.dart';
import 'dart:developer';


void main() {
  runApp(DiaryPage());
}

//검색어
String searchText = '';

// 리스트뷰에 표시할 내용
List<String> items = ['Day 1', 'Day 2', 'Day 3', 'Day 4'];
List<String> itemContents = [
  'Day 1 Contents',
  'Day 2 Contents',
  'Day 3 Contents',
  'Day 4 Contents'
];

// 플로팅 액션 버튼을 이용하여 항목을 추가할 제목과 내용
final TextEditingController titleController = TextEditingController();
final TextEditingController contentController = TextEditingController();


class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  DiaryPageState createState() => DiaryPageState();

}



var a = 1;

// 메인 클래스의 상태 상속
class DiaryPageState extends State<DiaryPage> {

  // 리스트뷰 카드 클릭 이벤트 핸들러
  void cardClickEvent(BuildContext context, int index) {
    String content = itemContents[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ContentPage(content: content),
      ),
    );
  }



  // 플로팅 액션 버튼 클릭 이벤트
  Future<void> addItemEvent(BuildContext context) {
    // 다이얼로그 폼 열기
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('항목 추가하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: '내용',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('추가'),
              onPressed: () {
                setState(() {
                  String title = titleController.text;
                  String content = contentController.text;
                  items.add(title);
                  itemContents.add(content);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['1', '2', '3', '4'];
    final List<int> colorCodes = <int>[50, 50, 50, 50];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         CupertinoPageRoute(builder:(context) => EditPage())
        //     );
        //     print(a);
        //     a ++;
        //   },
        //   label: Text('일기 추가'),
        // ),
        appBar: AppBar(
            title:Text('Diary',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: true,


            actions: [
              IconButton(icon: Icon(Icons.menu),
                  onPressed: () => print('fab pressed')
              )
            ],
            backgroundColor: Colors.deepPurple[400]
        ),

        bottomNavigationBar: BottomAppBar(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '검색어를 입력해주세요.',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                // items 변수에 저장되어 있는 모든 값 출력
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  // 검색 기능, 검색어가 있을 경우
                  if (searchText.isNotEmpty &&
                      !items[index]
                          .toLowerCase()
                          .contains(searchText.toLowerCase())) {
                    return SizedBox.shrink();
                  }
                  // 검색어가 없을 경우, 모든 항목 표시
                  else {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.elliptical(20, 20))),
                      child: ListTile(
                        title: Text(items[index]),
                        onTap: () => cardClickEvent(context, index),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        // 플로팅 액션 버튼
      ),
    );
  }
}

// 선택한 항목의 내용을 보여주는 추가 페이지
class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}