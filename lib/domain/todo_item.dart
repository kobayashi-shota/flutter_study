import 'package:flutter/cupertino.dart';

@immutable
class TodoItem {
  const TodoItem({
    /// インスタンス生成時にisCompleted=trueは有り得ない
    this.completed = false,
    required this.title,
  });

  final bool completed;
  final String title;

  TodoItem copyWith({
    bool? isCompleted,
    String? title,
  }) =>
      TodoItem(
        completed: isCompleted ?? this.completed,
        title: title ?? this.title,
      );
}
