import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class NoteCheckTile extends StatelessWidget {
  const NoteCheckTile(
      {super.key, required this.value, required this.label, this.onChanged});
  final bool value;
  final Function(bool?)? onChanged;
  final String label;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      side: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
      onChanged: onChanged,
      title: Text(
        label,
        style: textbody2Style.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
