import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  late final double _deviceWidth = MediaQuery.of(context).size.width;
  late double elapsedWidth = _deviceWidth * 0.2;
  late double separatorWidth = _deviceWidth * 0.05;

  ButtonStyle customButtonStyle(
    Color backgroundColor,
    FontWeight fontWeight,
  ) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(fontWeight: fontWeight),
      ),
    );
  }

  void start() {
    setState(() {
      _isRunning = true;
    });

    _stopwatch.start();

    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _milliseconds = _stopwatch.elapsedMilliseconds;
        });
      }
    });
  }

  void stop() {
    setState(() {
      _isRunning = false;
    });
    _stopwatch.stop();
    _timer.cancel();
  }

  void reset() {
    _stopwatch
      ..stop()
      ..reset();
    setState(() {
      _milliseconds = 0;
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours =
        (_milliseconds / (1000 * 60 * 60)).floor().toString().padLeft(2, '0');
    final minutes =
        ((_milliseconds / (1000 * 60)) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        ((_milliseconds / 1000) % 60).floor().toString().padLeft(2, '0');
    final milliseconds =
        (_milliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    final startButtonStyle = customButtonStyle(
      Colors.greenAccent,
      FontWeight.w400,
    );
    final stopButtonStyle = customButtonStyle(
      Colors.redAccent,
      FontWeight.w400,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Stopwatch App'),
      ),
      body: Center(
        widthFactor: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                '$hours:$minutes:$seconds.$milliseconds',
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Menlo',
                  fontSize: 1000,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : reset,
                  child: const Text('リセット'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isRunning ? stop : start,
                  style: _isRunning ? stopButtonStyle : startButtonStyle,
                  child: _isRunning ? const Text('停止') : const Text('開始'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
