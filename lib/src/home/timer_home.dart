import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event/timer_event.dart';
import '../bloc/state/timer_state.dart';
import '../bloc/timer_bloc.dart';

class TimerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desktop Timer App'),
      ),
      body: Center(
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
            ElevatedButton(
              onPressed: () {
                context.read<TimerBloc>().add(StartTimer());
              },
              child: const Text('Start Timer'),
            ),
            // Add widgets to display captured screenshots and headshots here
          ],
        ),
      ),
    );
  }
}