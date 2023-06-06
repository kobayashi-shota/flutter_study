import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;

  // Duration _elapsedTime = Duration.zero;
  late Timer _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  get startButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontWeight: FontWeight.w400),
        ),
      );

  get stopButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontWeight: FontWeight.w400),
        ),
      );
  double? _deviceWidth, _deviceHeight;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void startStopwatch() {
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

  void stopStopwatch() {
    setState(() {
      _isRunning = false;
    });
    _stopwatch.stop();
    _timer.cancel();
  }

  void resetStopwatch() {
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
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    String minutes =
        ((_milliseconds / (1000 * 60)) % 60).floor().toString()
            .padLeft(2, '0');
    String seconds =
        ((_milliseconds / 1000) % 60).floor().toString()
            .padLeft(2, '0');
    String milliseconds =
        (_milliseconds % 1000 ~/ 10).toString()
            .padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Stopwatch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: (_deviceWidth! / 4.0),
                  child: Text(
                    '$minutes:',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: (_deviceWidth! / 4.0),
                  child: Text(
                    '$seconds.',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: (_deviceWidth! / 4.0),
                  child: Text(
                    milliseconds,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning
                      ? () => stopStopwatch()
                      : () => startStopwatch(),
                  style: _isRunning ? stopButtonStyle : startButtonStyle,
                  child: _isRunning ? const Text('停止') : const Text('開始'),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: _isRunning ? null : () => resetStopwatch(),
                  child: const Text('リセット'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
