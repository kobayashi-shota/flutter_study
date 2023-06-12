import 'package:flutter_study/domain/todo_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isCompletedの初期値がfalseである', () {
    const todoItem = TodoItem(title: 'test1');
    expect(todoItem.completed == false, true);
  });

  test('copyWithしたインスタンスがcopy元と異なる', () {
    const todoItem = TodoItem(title: 'test2');
    final copiedTodoItem = todoItem.copyWith();
    expect(todoItem == copiedTodoItem, false);
  });

  test('copy先の変更はcopy元に影響しない', () {
    const todoItem = TodoItem(title: 'test3');
    var copiedTodoItem = todoItem.copyWith();
    copiedTodoItem = copiedTodoItem.copyWith(title: 'test3のタイトルを変更しました');
    // ..title = 'huge'; でのタイトル変更は不可
    expect(todoItem.title != copiedTodoItem.title, true);
  });
}
