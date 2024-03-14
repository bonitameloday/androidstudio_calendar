import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendar/home.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();
XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class EditPage extends StatelessWidget {


  final DateTime selectedDate;
  EditPage(
      {required this.selectedDate, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
          style: TextStyle(
            color: Colors.white
          ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("삭제할까요?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("삭제"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("취소"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),

      bottomSheet: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
        color: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("저장할까요?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text("저장"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text("취소"),
                    ),
                  ],
                );
              },
            );
          },
        ),

                )
      ),

    ),

    body: SingleChildScrollView(
      padding: EdgeInsets.all(5),
      reverse: true,
          child: Column(
              children: <Widget>[
              Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),

              TextField(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                //obscureText: true,
                decoration: InputDecoration(
                  hintText: '제목을 적어요.',
                ),
              ),

              TextField(
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                keyboardType: TextInputType.multiline,
                maxLines: 18,
                //obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: '오늘 하루를 기록해요.',
                ),
              ),
              ],
          ),
        ),


    );

  }
}
