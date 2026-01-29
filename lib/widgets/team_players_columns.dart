// lib/widgets/team_players_columns.dart
import 'package:flutter/material.dart';
import '../models/goal.dart';

/// Toont per team twee kolommen met knoppen:
/// - links: Doelpunt #1..#8
/// - rechts: Doelpunt #9..#16
class TeamPlayersColumns extends StatelessWidget {
  final Team team;
  final void Function(int playerNumber) onPick;
  final bool showGoalCount;
  final Map<int, int>? goalCountsByPlayer;

  const TeamPlayersColumns({
    super.key,
    required this.team,
    required this.onPick,
    this.showGoalCount = false,
    this.goalCountsByPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final isHome = team == Team.home;
    final color = isHome ? Colors.blue.shade600 : Colors.red.shade600;

    Widget buildButton(int number) {
      final countLabel = showGoalCount
          ? ' (${(goalCountsByPlayer ?? const {})[number] ?? 0})'
          : '';
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(0.10),
            foregroundColor: color,
            side: BorderSide(color: color.withOpacity(0.30)),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () => onPick(number),
          child: Text('Doelpunt #$number$countLabel'),
        ),
      );
    }

    // Linkerkolom 1..8, rechterkolom 9..16
    final leftNumbers  = List<int>.generate(8, (i) => i + 1);
    final rightNumbers = List<int>.generate(8, (i) => i + 9);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Zonder vaste hoogte: kolommen groeien mee, maar als de ruimte krap is, mag scrollen
        final column = (List<int> nums) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: nums.map(buildButton).toList(),
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: column(leftNumbers)),
            const SizedBox(width: 12),
            Expanded(child: column(rightNumbers)),
          ],
        );
      },
    );
  }
}
