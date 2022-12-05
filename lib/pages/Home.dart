import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _userToDo = '';
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['Buy milk', 'Wash dishes', 'Купить картошку']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(
              child: ListTile(
              title: Text(todoList[index]),
              trailing: IconButton(
              icon: Icon(
                Icons.delete_forever_rounded,
                color: Colors.deepOrangeAccent
              ),
              onPressed: () {
                setState(() {
                  todoList.removeAt(index);
                });
              }
            ),
          ),
        ),
            onDismissed: (direction) {
             // if (direction == DismissDirection.)
             setState(() {
               todoList.removeAt(index);
             });
            },
            );
        }
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Добавить элемент'),
                content: TextField(
                  onChanged: (String value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  ElevatedButton(onPressed: () {
                    setState(() {
                      todoList.add(_userToDo);
                    });
                    Navigator.of(context).pop();
                  }, child: Text('Добавить'))
                ],
              );
            });
          },
          child: Icon(
            Icons.note_add,
            color: Colors.white,
          )
    ),
  );
  }
}