import 'package:flutter/foundation.dart';
import 'package:sgroup/models/toDoListModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<void> saveToDoItemsToLocalBase(List<ToDoListModel> orderList) async {
  final SharedPreferences prefs = await _prefs;
  final String encodeData = ToDoListModel.encode(orderList);
  prefs.setString('taskItems', encodeData).then((bool success) {
    if (kDebugMode) {
      print("taskItems --> $encodeData");
    }
  });
}

void removeToDoItemsFromLocalBaseValues() async {
  final SharedPreferences prefs = await _prefs;
  prefs.remove('taskItems').then((bool success) {
    if (kDebugMode) {
      print("taskItems_removed");
    }
  });
}