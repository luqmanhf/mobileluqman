import 'package:flutter/material.dart';
import 'package:mobileluqman/noteapp/models/note.dart';
import 'package:intl/intl.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.orange.shade400,
  Colors.red.shade500,
  Colors.pinkAccent.shade100,
  Colors.purpleAccent.shade100,
];

class NoteCardWidget extends StatelessWidget {
  final Note note;
  final int index;
  const NoteCardWidget({super.key, required this.note, required this.index});
  @override
  Widget build (BuildContext context) {
    final time = DateFormat.yMMMd().add_jms().format(note.createdTime);
    final minHeight = getMinHeight(index);
    final color = _lightColors[index %_lightColors.length];
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}