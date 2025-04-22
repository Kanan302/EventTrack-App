import 'dart:async';

import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

class ValidityTimer extends StatefulWidget {
  const ValidityTimer({super.key});

  @override
  State<ValidityTimer> createState() => ValidityTimerState();
}

class ValidityTimerState extends State<ValidityTimer> {
  int _start = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _start = 30;
    });

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer!.cancel();
      }
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${AppTexts.validityTime} $timerText',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
