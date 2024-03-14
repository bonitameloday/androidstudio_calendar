import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(PlannerPage());
}

class Todo {
  bool isDone = false;
  String title = '';

  Todo(this.title);
}


class PlannerPage extends StatelessWidget {
  const PlannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'to do list',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TodoListPage(),

    );
  }
}



class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);


  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
// 할 일 목록을 저장할 리스트
  final _items = <Todo>[];

// 할 일 문자열 조작을 위한 컨트롤러
  final _todoController = TextEditingController();


  @override
  void dispose(){
    _todoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar (
          title: Text('To Do List',
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
                onPressed: () => print('fab pressed') //스터디, 일반 선택
            )
          ],
          backgroundColor: Colors.deepPurple[400]
      ),
      body: SingleChildScrollView(
      child: ( _items == null)
          ? Center(
        child: Text('오늘의 할 일을 알려주세요!',
          style: GoogleFonts.nanumGothic(
            textStyle: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.bold,),
          ),
        ),
      ) : Column(
        children:  (_items
            .map((e) => Container(
          height: 70.0,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0
          ),
          padding: const EdgeInsets.only(left: 10.0,),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: Colors.black,
                width: 0.5
            ),
          ),

        ),
        ))
            .toList(),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(10.0),
            //height: 500,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'To do', style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(thickness: 1.2),
                SizedBox(height: 20),
                TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),//포커스 시 TextFromField 디자인
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),//기본 TextFormField 디자인
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '내용을 입력하세요',
                    hintStyle: GoogleFonts.nanumGothic(
                      textStyle: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 180.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 135.0),
                  width: MediaQuery.of(context).size.width,
                  //height: 200.0,
                  child: Row(
                    children:  [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) -100 ,
                        child: ElevatedButton( onPressed: () => _addTodo(Todo(_todoController.text)),
                          //color: Colors.yellow[200],
                          child: Text(
                            'OK',
                            style: GoogleFonts.nunito(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[200],
                          ),
                        ),
                      ),


                    ],

                  ),

                ),

                Expanded(child: ListView(
                  children: _items.map((todo) => _buildItemWidget(todo)).toList(),
                ),),
              ],

            ),

          ),

        ),
      ),


    );
  }
  Widget _buildItemWidget(Todo todo) {

    return ListTile(

//onTap: () => _toggleTodo(todo), // Todo : 클릭 시 완료/취소 되도록 수정
      title: Text(
        todo.title,
        style: todo.isDone ?
        const TextStyle(
          decoration: TextDecoration.lineThrough, // 취소선
          fontStyle: FontStyle.italic, // 이탤릭체
        )
            : null,
      ),

      leading: Checkbox(
        value: todo.isDone,
        onChanged: (value) {
          setState(() {
            todo.isDone = value !;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: ()=>_deleteTodo(todo), //  Todo : 쓰레기통 클릭 시 삭제되도록
      ),
    );
  }

  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);

    });
  }

// 할 일 삭제 메서드
  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

// 할 일 완료/미완료 메서드
  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}