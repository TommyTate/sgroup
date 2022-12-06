import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sgroup/models/toDoListModel.dart';
import 'package:sgroup/services/save_values_to_local_base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sgroup/models/global.dart' as global;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userToDo = '';
  List<ToDoListModel> todoList = []; //Делаем список типа ToDoListModel
  final Future<SharedPreferences> _prefs = SharedPreferences
      .getInstance(); //Объявляем переменную для извлечения строк из shared Preferences
  @override
  void initState() {
    super.initState();

    //Задаем начальное состояние списка
    _getTasks();
  }

  _getTasks() async {
    final SharedPreferences prefs =
        await _prefs; // инициируем подключение к prefs
    final String? tasks = prefs.getString(
        'taskItems'); // запрашиваем строку taskItems и сохранаем ее в tasks
    //проверяем строку tasks
    if (tasks == null || global.taskList == null) {
      setState(() {
        global.taskList = [];
      });

      print('Дел нет');
    } else {
      print('дела есть');
      setState(() {
        global.taskList = ToDoListModel.decode(tasks);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
      ),
      body:
          //проверям список дел, перед отображением
          //если он пуст, то выводим сообщение
          //иначе даем список дел

          global.taskList.isNotEmpty
              ? ListView.builder(
                  itemCount: global.taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(global.taskList[index].title),
                      child: Card(
                        child: ListTile(
                          title: Text(global.taskList[index].title),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_forever_rounded,
                                  color: Colors.deepOrangeAccent),
                              onPressed: () {
                                //удаляем элемент списка и сохраняем новое состояния списка
                                setState(() {
                                  global.taskList.removeAt(index);
                                });
                                removeToDoItemsFromLocalBaseValues(); //удаление локальных данных из SharedPreferences
                                saveToDoItemsToLocalBase(global
                                    .taskList); //Затем сохраняем обновленный список в SharedPreferences
                              }),
                        ),
                      ),
                      onDismissed: (direction) {
                        // if (direction == DismissDirection.)
                        setState(() {
                          global.taskList.removeAt(index);
                        });
                        removeToDoItemsFromLocalBaseValues(); //удаление локальных данных из SharedPreferences
                        saveToDoItemsToLocalBase(global
                            .taskList); //Сохраняем обновленный список в SharedPreferences
                      },
                    );
                  })
              : Center(
                  child: Text('Дела отсутствуют',
                      style: TextStyle(color: Colors.grey))),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Добавить элемент'),
                    content: TextField(
                      onChanged: (String value) {
                        _userToDo = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            //Устанавливаем новое состояние списка, добавляя новое значение

                            setState(() {
                              global.taskList
                                  .add(ToDoListModel(title: _userToDo));
                            });
                            saveToDoItemsToLocalBase(global
                                .taskList); //Затем сохраняем обновленный список в SharedPreferences
                            _getTasks();
                            Navigator.of(context).pop();
                          },
                          child: Text('Добавить'))
                    ],
                  );
                });
          },
          child: Icon(
            Icons.note_add,
            color: Colors.white,
          )),
    );
  }
}
