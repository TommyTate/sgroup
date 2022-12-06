import 'dart:convert';

class ToDoListModel {
  String title = '';

  ToDoListModel({this.title = ''});

  factory ToDoListModel.fromJson(Map<String, dynamic> parsedJson) =>
      ToDoListModel(title: parsedJson['title'] ?? null);
  static Map<String, dynamic> toMap(ToDoListModel toDoList) => {
        'title': toDoList.title,
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
