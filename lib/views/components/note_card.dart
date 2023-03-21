import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/controller/notes/cubit/note_cubit.dart';
import 'package:todo/views/screens/note_edit_page/note_edit_screen.dart';
import '../../data/models/note.dart';
import 'note_slideable.dart';

import '../constants/colors.dart';
import '../constants/style.dart';
import '../screens/detailpage/note_detail_screen.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.note,
    required this.color,
  }) : super(key: key);
  final Note note;
  final Color color;
  String get state {
    final important = note.isImportant == 1 ? 'Important' : '';
    final todo = note.isTodo == 1 ? 'Todo' : '';
    final result = ['Note', important, todo].join(' | ');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return NoteSlideable(
      delete: _delete,
      update: _update,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () => _goToDetailScreen(context),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color,
              kdarkpinkColor,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _notedivider(),
                const SizedBox(height: 15),
                _title(),
                const SizedBox(height: 5),
                _textBody(),
                const SizedBox(height: 15),
                _dateAndState()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateAndState() {
    return Row(
      children: [
        Text(
          state,
          style: textbody2Style.copyWith(color: lightColor),
        ),
        const Spacer(),
        Text(
          note.datetime,
          style: textbody2Style.copyWith(color: lightColor),
        ),
      ],
    );
  }

  Widget _textBody() {
    return Text(
      note.content,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      style: textbody2Style.copyWith(color: lightgrayColor),
    );
  }

  Widget _title() {
    return Row(
      children: [
        const Icon(Icons.note, color: Colors.white),
        const SizedBox(width: 5),
        Text(
          note.title,
          style: textsubtitleStyle,
          softWrap: true,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _notedivider() {
    return Center(
      child: Column(
        children: [
          Container(
            height: 2,
            width: 30,
            color: lightColor,
          ),
          const SizedBox(height: 2),
          Container(
            height: 2,
            width: 15,
            color: lightColor,
          ),
        ],
      ),
    );
  }

  void _goToDetailScreen(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          child: NoteDetailScreen(
            note: note,
            state: state,
            color: color,
          ),
          type: PageTransitionType.topToBottom,
          curve: Curves.easeInSine,
        ));
  }

  void _update(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            child: NoteEditScreen(note: note),
            type: PageTransitionType.topToBottom));
  }

  void _delete(BuildContext context) {
    BlocProvider.of<NoteCubit>(context).deleteNote(note);
  }
}
