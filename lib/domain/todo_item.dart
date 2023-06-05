import 'package:flutter/material.dart';

class TodoItem {
  String title;
  bool completed;

  TodoItem({required this.title, this.completed = false});
}
