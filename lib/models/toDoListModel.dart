import 'dart:convert';

class ToDoListModel {
  String title = '';
  String hour = '';
  String minute = '';

  ToDoListModel({this.title = '', this.hour= '', this.minute = ''});

  factory ToDoListModel.fromJson(Map<String, dynamic> parsedJson) =>
      ToDoListModel(hour: parsedJson['hour'], minute: parsedJson['minute'], title: parsedJson['title'] ?? null);
  static Map<String, dynamic> toMap(ToDoListModel toDoList) => {
        'title': toDoList.title,
        'hour': toDoList.hour,
        'minute': toDoList.minute,
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
