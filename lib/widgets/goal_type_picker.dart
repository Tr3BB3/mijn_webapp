// lib/widgets/goal_type_picker.dart

import 'package:flutter/material.dart';
import '../models/goal.dart';

Future<GoalType?> showGoalTypePicker(BuildContext context) async {
  final items = [
    GoalType.smallChance2m,
    GoalType.midRange5m,
    GoalType.longRange7m,
    GoalType.turnaround,
    GoalType.throughBall,
    GoalType.freeThrow,
    GoalType.penalty,
  ];

  return showModalBottomSheet<GoalType>(
    context: context,
    showDragHandle: true,
    builder: (ctx) {
      return ListView(
        children: items.map((type) {
          return ListTile(
            title: Text(type.label),
            onTap: () => Navigator.pop(ctx, type),
          );
        }).toList(),
      );
    },
  );
}