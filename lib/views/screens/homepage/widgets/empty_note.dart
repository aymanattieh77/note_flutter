import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class EmptyNote extends StatelessWidget {
  const EmptyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/add_notes.png',
              height: 200,
            ),
            Text(
              'No Notes Add yet',
              style: textLobsterStyle.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
