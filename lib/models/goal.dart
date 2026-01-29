// lib/models/goal.dart
import 'package:flutter/foundation.dart';

/// Welke ploeg scoorde.
enum Team { home, away }

/// Een doelpunt met tijdstip (in seconden sinds start) en het team.
@immutable
class Goal {
  final int secondStamp;
  final Team team;

  const Goal({
    required this.secondStamp,
    required this.team,
  });

  String get formattedTime {
    final m = (secondStamp ~/ 60).toString().padLeft(2, '0');
    final s = (secondStamp % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}