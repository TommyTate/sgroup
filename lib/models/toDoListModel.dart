import 'dart:convert';

class ToDoListModel {
  String title = '';
  String time = '';

  ToDoListModel({this.title = '', this.time = ''});

  factory ToDoListModel.fromJson(Map<String, dynamic> parsedJson) =>
      ToDoListModel(time: parsedJson['time'], title: parsedJson['title'] ?? null);
  static Map<String, dynamic> toMap(ToDoListModel toDoList) => {
        'title': toDoList.title,
        'time': toDoList.time,
      };

  static String encode(List<ToDoListModel> list) => json.encode(
        list
            .map<Map<String, dynamic>>((items) => ToDoListModel.toMap(items))
            .toList(),
      );

  static List<ToDoListModel> decode(String list) =>
      (json.decode(list) as List<dynamic>)
          .map<ToDoListModel>((item) => ToDoListModel.fromJson(item))
          .toList();
}
