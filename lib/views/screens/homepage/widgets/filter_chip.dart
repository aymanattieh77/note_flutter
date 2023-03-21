// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo/views/constants/style.dart';

class NoteChip extends StatelessWidget {
  const NoteChip({
    Key? key,
    required this.index,
    required this.isSelect,
    required this.label,
    required this.press,
  }) : super(key: key);
  final int index;
  final List<bool> isSelect;
  final String label;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ActionChip(
        label: Text(
          label,
          style: textbodyStyle.copyWith(
            color: isSelect[index]
                ? Theme.of(context).canvasColor
                : Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: isSelect[index]
            ? Theme.of(context).primaryColor
            : Theme.of(context).canvasColor,
        side: BorderSide(
          color: isSelect[index] ? Theme.of(context).primaryColor : Colors.grey,
        ),
        onPressed: press,
      ),
    );
  }
}
