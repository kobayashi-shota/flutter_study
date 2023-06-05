import 'package:flutter/material.dart';

class CountUpPage extends StatefulWidget {
  const CountUpPage({super.key, required this.title});

  final String title;

  @override
  State<CountUpPage> createState() => _CountUpPageState();
}

class _CountUpPageState extends State<CountUpPage> {
  int _counter = 0;

  final int limit = 100;

  bool _isLimit() {
    return _counter == limit;
  }

  Future<void> _resetCountAndPop() async {
    setState(() {
      _counter = 0;
    });

    Navigator.pop(context);
  }

  void _incrementCounter() {
    if (_isLimit()) {
      _showLimitDialog();
      return;
    }

    setState(() {
      _counter++;
    });
  }

  void _showLimitDialog() {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            SimpleDialog(title: const Text('お疲れ様でした🎉'), children: [
              SimpleDialogOption(
                onPressed: _resetCountAndPop,
                child: const Text(
                  'カウントをリセット',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
              ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'キャンセル',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          '現在のカウント: $_counter',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
