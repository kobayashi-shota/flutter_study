import 'package:flutter/material.dart';
import 'package:flutter_study/domain/todo_item.dart';

class TodoAppScreen extends StatefulWidget {
  const TodoAppScreen({super.key});

  @override
  State<TodoAppScreen> createState() => _TodoAppScreenState();
}

class _TodoAppScreenState extends State<TodoAppScreen> {
  final List<TodoItem> todoItems = [];

  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  void _addTodoItem() {
    if (_addFormKey.currentState!.validate()) {
      final title = _textEditingController.text.trim();

      setState(() {
        todoItems.add(TodoItem(title: title));
      });

      _textEditingController.clear();
    }
  }

  void _editTodoItem(int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        var editedTitle = '';
        return AlertDialog(
          title: Text('Todoの編集: ${todoItems[index].title}'),
          content: Form(
            key: _editFormKey,
            child: TextFormField(
              initialValue: todoItems[index].title,
              decoration: const InputDecoration(
                labelText: 'タイトル',
              ),
              onChanged: (title) {
                editedTitle = title;
              },
              validator: validate,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                if (_editFormKey.currentState!.validate()) {
                  setState(() {
                    todoItems[index] =
                        todoItems[index].copyWith(title: editedTitle);
                  });
                  _textEditingController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodoItem(TodoItem todoItem) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Todoの削除'),
          content: Text('${todoItem.title}を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todoItems.remove(todoItem);
                });
                Navigator.pop(context);
              },
              child: const Text(
                '削除',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String? validate(String? title) {
    if (title!.isEmpty) {
      return 'タイトルを入力してください';
    }

    final hasDuplicate = todoItems.any((TodoItem item) {
      return item.title == title;
    });

    if (hasDuplicate) {
      return '同じタイトルのTodoが既に存在します';
    }

    return null;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoアプリ'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _addFormKey,
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                  ),
                  validator: validate,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addTodoItem,
                child: const Text('追加'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: todoItems.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        todoItems[index].title,
                        style: TextStyle(
                          color: todoItems[index].completed
                              ? Colors.grey
                              : Colors.black,
                          decoration: todoItems[index].completed
                              ? TextDecoration.lineThrough
                              : null,
                          fontSize: 24,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: todoItems[index].completed,
                            onChanged: (value) {
                              setState(() {
                                todoItems[index] = todoItems[index]
                                    .copyWith(isCompleted: value ?? false);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteTodoItem(todoItems[index]);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _editTodoItem(index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
