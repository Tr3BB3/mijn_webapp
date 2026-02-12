// lib/widgets/team_players_columns.dart
import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../models/players.dart';

/// Twee kolommen per team:
/// - links: 1..8
/// - rechts: 9..16
/// Knoppen tonen de NAAM van de speler; klik → onPick(nummer)
class TeamPlayersColumns extends StatelessWidget {
  final Team team;
  final TeamPlayers players;
  final void Function(int) onPick;
  final bool showGoalCount;
  final Map<int, int>? goalCountsByPlayer;

  const TeamPlayersColumns({
    super.key,
    required this.team,
    required this.players,
    required this.onPick,
    this.showGoalCount = false,
    this.goalCountsByPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final color = team == Team.home ? Colors.blue : Colors.red;

    Widget button(int n) {
      final name = players.getName(n);
      final count =
          showGoalCount ? " (${goalCountsByPlayer?[n] ?? 0})" : "";

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(.12),
            foregroundColor: color,
          ),
          onPressed: () => onPick(n),
          child: Text("$name$count", overflow: TextOverflow.ellipsis),
        ),
      );
    }

    final left = List.generate(8, (i) => i + 1);
    final right = List.generate(8, (i) => i + 9);

    return LayoutBuilder(
      builder: (context, constraints) {
        // If narrow (e.g. phones) show a single stacked column of all players
        if (constraints.maxWidth < 420) {
          final all = List.generate(16, (i) => i + 1);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: all.map(button).toList(),
          );
        }

        // Otherwise show two columns (1..8 and 9..16)
        return Row(
          children: [
            Expanded(child: Column(children: left.map(button).toList())),
            const SizedBox(width: 12),
            Expanded(child: Column(children: right.map(button).toList())),
          ],
        );
      },
    );
  }
}