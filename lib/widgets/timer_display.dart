// lib/widgets/timer_display.dart
import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int seconds;
  final bool isRunning;

  const TimerDisplay({
    super.key,
    required this.seconds,
    required this.isRunning,
  });

  String _format(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final color = isRunning ? Colors.green : Colors.grey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _format(seconds),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isRunning ? Icons.play_arrow : Icons.pause, color: color),
            const SizedBox(width: 6),
            Text(
              isRunning ? 'Loopt' : 'Gestopt',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: color,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
