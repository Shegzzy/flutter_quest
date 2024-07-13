import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../bloc/event/timer_event.dart';
import '../bloc/state/timer_state.dart';
import '../bloc/timer_bloc.dart';

class TimerHome extends StatefulWidget {
  @override
  _TimerHomeState createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _screenshot;

  Future<void> _captureScreenshot() async {
    try {
      final Uint8List? screenshot = await screenshotController.capture();
      if (screenshot != null) {
        setState(() {
          _screenshot = screenshot;
        });
      }
    } catch (e) {
      print("Failed to capture screenshot: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop Timer App'),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  int seconds = 0;
                  if (state is TimerRunning) {
                    seconds = state.seconds;
                  }
                  return Text(
                    '$seconds seconds',
                    style: const TextStyle(fontSize: 48),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(StartTimer());
                      _captureScreenshot();
                    },
                    child: const Text('Start Timer'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(StopTimer());
                    },
                    child: const Text('Stop Timer'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocListener<TimerBloc, TimerState>(
                listener: (context, state) {
                  if (state is TimerRunning) {
                    _captureScreenshot();
                  }
                },
                child: _screenshot != null
                    ? Image.memory(
                  _screenshot!,
                  width: 800,
                  height: 400,
                )
                    : const Text("No screenshot captured"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}