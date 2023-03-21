import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isContent = false,
    required this.controller,
    this.isDate = false,
  });
  final String label;
  final String hint;
  final IconData icon;
  final bool isContent;
  final TextEditingController controller;
  final bool isDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              textsubtitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          enabled: isDate ? false : true,
          style: textbody2Style.copyWith(color: Theme.of(context).primaryColor),
          maxLines: isContent ? 5 : 1,
          decoration: InputDecoration(
            enabled: true,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
