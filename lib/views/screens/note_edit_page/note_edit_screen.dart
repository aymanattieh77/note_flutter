import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:todo/controller/notes/cubit/note_cubit.dart';

import 'package:todo/data/models/note.dart';

import 'package:todo/views/screens/homepage/home_screen.dart';

import 'package:todo/views/screens/note_edit_page/widgets/note_check_tile.dart';

import 'widgets/note_text_filed.dart';

class NoteEditScreen extends StatefulWidget {
  const NoteEditScreen({super.key, this.note});
  final Note? note;
  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dateController = TextEditingController();
  bool isImportant = false;
  bool isTodo = false;
  @override
  void initState() {
    super.initState();
    dateController.text = '';
    titleController.text = '';
    contentController.text = '';
    if (widget.note != null) {
      dateController.text = widget.note!.datetime;
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      isImportant = widget.note!.isImportant == 1 ? true : false;
      isTodo = widget.note!.isTodo == 1 ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteTextField(
                label: 'Note Title',
                hint: 'Title',
                icon: Icons.note,
                controller: titleController,
              ),
              const SizedBox(height: 12),
              NoteTextField(
                label: 'Note Content',
                hint: 'Enter note content here',
                icon: Icons.content_copy,
                isContent: true,
                controller: contentController,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: saveDatetime,
                child: NoteTextField(
                  label: 'Note Date',
                  hint: '2000, 20, 12',
                  icon: Icons.date_range,
                  controller: dateController,
                  isDate: true,
                ),
              ),
              _noteCheck(),
              _saveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.note == null ? createNote : updateNote,
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          onPrimary: Theme.of(context).canvasColor,
        ),
        child: const Text('Save Note'),
      ),
    );
  }

  Widget _noteCheck() {
    return Column(
      children: [
        NoteCheckTile(
          value: isImportant,
          label: 'Important',
          onChanged: (value) {
            setState(() {
              isImportant = value!;
            });
          },
        ),
        NoteCheckTile(
          value: isTodo,
          label: 'Todo',
          onChanged: (value) {
            setState(() {
              isTodo = value!;
            });
          },
        ),
      ],
    );
  }

  void saveDatetime() async {
    final date = await showDate();

    setState(() {
      dateController.text =
          date != null ? DateFormat.yMMMEd().format(date) : dateController.text;
    });
  }

  void createNote() async {
    if (titleController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        dateController.text.isNotEmpty) {
      await BlocProvider.of<NoteCubit>(context).insertNote(
        Note(
          title: titleController.text,
          content: contentController.text,
          datetime: dateController.text,
          isImportant: isImportant ? 1 : 0,
          isTodo: isTodo ? 1 : 0,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  void updateNote() async {
    final note = widget.note!.copyWith(
        title: titleController.text,
        content: contentController.text,
        datetime: dateController.text,
        isImportant: isImportant ? 1 : 0,
        isTodo: isTodo ? 1 : 0);
    await BlocProvider.of<NoteCubit>(context).updateNote(note);

    //  ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const HomeScreen(), type: PageTransitionType.leftToRight));
  }

  Future<DateTime?> showDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
  }
}
