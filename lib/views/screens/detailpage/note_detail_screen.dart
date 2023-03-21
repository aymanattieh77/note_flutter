import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:todo/views/screens/note_edit_page/note_edit_screen.dart';

import '../../../data/models/note.dart';

import '../../constants/style.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({
    super.key,
    required this.note,
    required this.state,
    required this.color,
  });
  final Note note;
  final String state;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                noteBody(),
              ],
            ),
          )),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: Text(note.title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: NoteEditScreen(note: note),
                    type: PageTransitionType.leftToRight));
          },
          icon: Icon(
            Icons.edit,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget noteBody() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_noteContent(), const Spacer(), _noteState()],
      ),
    );
  }

  Widget _noteContent() {
    return Text(
      note.content,
      softWrap: true,
      style: textbody2Style.copyWith(color: Colors.white),
    );
  }

  Widget _noteState() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(state, style: textbodyStyle.copyWith(color: Colors.white)),
          const Spacer(),
          Text(
            note.datetime,
            style: textbodyStyle.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
