import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.onTap,
    required this.settingsTapped,
    required this.habitStarted,
    required this.timeSpent,
    required this.timeGoal,
  });

  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds ~/ 60).toString();

    return ("$mins:$secs");
  }

  double percentCalculated() {
    double calcPercent = timeSpent / (timeGoal * 60);
    return calcPercent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Stack(children: [
                      Center(
                        child:
                            Icon(habitStarted ? Icons.pause : Icons.play_arrow),
                      ),

                      //percent indicator
                      CircularPercentIndicator(
                        radius: 60,
                        percent:
                            percentCalculated() < 1 ? percentCalculated() : 1,
                        progressColor: percentCalculated() > 0.5
                            ? (percentCalculated() > 0.8
                                ? Colors.green
                                : Colors.amber)
                            : Colors.red,
                      ),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${formatToMinSec(timeSpent)} / $timeGoal = ${(percentCalculated() * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTapped,
              child: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
