import 'package:flutter/material.dart';
import '../../../constants/style.dart';

class NoteFloatActionButton extends StatelessWidget {
  const NoteFloatActionButton({super.key, required this.press});
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColor,
      tooltip: 'Add Note',
      onPressed: press,
      icon: Icon(
        Icons.add,
        color: Theme.of(context).canvasColor,
        size: 20,
      ),
      label: Text(
        'Add Note',
        style: textbodyStyle.copyWith(color: Theme.of(context).canvasColor),
      ),
    );
  }
}
