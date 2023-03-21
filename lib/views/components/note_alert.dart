import 'package:flutter/material.dart';
import 'package:todo/views/constants/colors.dart';

class NoteAlert extends StatelessWidget {
  const NoteAlert({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: lightColor,
        child: Text(
          error,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ok')),
      ],
    );
  }
}
