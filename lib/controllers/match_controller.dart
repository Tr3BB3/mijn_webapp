// lib/controllers/match_controller.dart

import 'dart:async';
import '../models/goal.dart';
import '../models/players.dart';

class MatchController {
  // Scores
  int homeScore = 0;
  int awayScore = 0;

  // Doelpuntenlijst
  final List<Goal> goals = [];

  // Timer
  bool isRunning = false;
  int elapsedSeconds = 0;
  Timer? _timer;

  // Spelersnamen
  TeamPlayers homePlayers = TeamPlayers.default16();
  TeamPlayers awayPlayers = TeamPlayers.default16();

  // UI callback
  final void Function()? onTick;

  MatchController({this.onTick});

  // Timer
  void start() {
    if (isRunning) return;
    isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsedSeconds++;
      onTick?.call();
    });
    onTick?.call();
  }

  void stop() {
    isRunning = false;
    _timer?.cancel();
    _timer = null;
    onTick?.call();
  }

  void reset() {
    stop();
    elapsedSeconds = 0;
    homeScore = 0;
    awayScore = 0;
    goals.clear();
    onTick?.call();
  }

  // Goal toevoegen (met optionele 'concededPlayerNumber')
  void addGoal(
    Team team,
    int playerNumber,
    GoalType type, {
    int? concededPlayerNumber,
  }) {
    goals.add(
      Goal(
        secondStamp: elapsedSeconds,
        team: team,
        playerNumber: playerNumber,
        type: type,
        concededPlayerNumber: concededPlayerNumber,
      ),
    );

    if (team == Team.home) {
      homeScore++;
    } else {
      awayScore++;
    }
    onTick?.call();
  }

  // Spelers updaten
  void updateHomePlayers(TeamPlayers players) {
    homePlayers = players;
    onTick?.call();
  }

  void updateAwayPlayers(TeamPlayers players) {
    awayPlayers = players;
    onTick?.call();
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}