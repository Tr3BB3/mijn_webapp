// lib/models/goal.dart
import 'package:flutter/foundation.dart';

/// Team aanduiding
enum Team { home, away }

/// Type doelpunt
enum GoalType {
  smallChance2m, // Klein kansje 2m
  midRange5m,    // Mid range 5m
  longRange7m,   // Afstander 7m
  turnaround,    // Omdraaibal
  throughBall,   // Doorloopbal
  freeThrow,     // Vrije bal
  penalty,       // Strafworp
}

extension GoalTypeLabel on GoalType {
  String get label {
    switch (this) {
      case GoalType.smallChance2m:
        return "Klein kansje 2m";
      case GoalType.midRange5m:
        return "Mid range 5m";
      case GoalType.longRange7m:
        return "Afstander 7m";
      case GoalType.turnaround:
        return "Omdraaibal";
      case GoalType.throughBall:
        return "Doorloopbal";
      case GoalType.freeThrow:
        return "Vrije bal";
      case GoalType.penalty:
        return "Strafworp";
    }
  }
}

/// Doelpunt met tijd, team, scorer (#), type en (optioneel) wie 'm tegen kreeg (#).
@immutable
class Goal {
  final int secondStamp;
  final Team team;
  final int playerNumber;
  final GoalType type;

  /// De speler die de goal tegen kreeg (nummer uit het verdedigende team).
  final int? concededPlayerNumber;

  const Goal({
    required this.secondStamp,
    required this.team,
    required this.playerNumber,
    required this.type,
    this.concededPlayerNumber,
  });

  String get formattedTime {
    final m = (secondStamp ~/ 60).toString().padLeft(2, '0');
    final s = (secondStamp % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get teamLabel => team == Team.home ? "Thuis" : "Uit";
}