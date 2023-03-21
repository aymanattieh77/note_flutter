import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:todo/controller/notes/cubit/note_cubit.dart';
import 'package:todo/views/components/note_alert.dart';

import 'package:todo/views/screens/homepage/widgets/empty_note.dart';

import '../note_edit_page/note_edit_screen.dart';

import '../../../controller/theme/theme_cubit.dart';

import '../../../data/models/note.dart';

import '../../components/note_card.dart';
import '../../constants/constants.dart';

import 'widgets/filter_chip.dart';
import 'widgets/note_float_action_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //all   //important // to do
  List<bool> isSelected = [true, false, false];
  List<Note> notes = [];
  List<Note> importantNotes = [];
  List<Note> todoNotes = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoteCubit>(context).getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleNote(context),
              const SizedBox(height: 10),
              _rowNotes(),
              blocNote(),
            ],
          ),
        ),
      ),
      floatingActionButton: NoteFloatActionButton(press: goToEditScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget blocNote() {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        if (state is NoteLoaded) {
          notes = state.notes;
          importantNotes =
              notes.where((note) => note.isImportant == 1).toList();
          todoNotes = notes.where((note) => note.isTodo == 1).toList();
          return notes.isNotEmpty ? noteList(filterNotes()) : const EmptyNote();
        } else if (state is NoteFailure) {
          return NoteAlert(error: state.error);
        } else {
          return showProgressLoader();
        }
      },
    );
  }

  void goToEditScreen() {
    Navigator.push(
        context,
        PageTransition(
          child: const NoteEditScreen(),
          type: PageTransitionType.bottomToTop,
        ));
  }

  List<Note> filterNotes() {
    if (isSelected[0] == true) {
      return notes;
    } else if (isSelected[1] == true) {
      return importantNotes;
    } else {
      return todoNotes;
    }
  }

  Widget noteList(List<Note> notes) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(
            note: note,
            color: getColor(note),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }

  Color getColor(Note note) {
    if (note.isImportant == 1 && note.isTodo == 0) {
      return cardImportantColor;
    } else if (note.isTodo == 1 && note.isImportant == 0) {
      return cardTodoColor;
    } else if (note.isImportant == 1 && note.isTodo == 1) {
      return kdarkpinkColor;
    } else {
      return cardNoteColor;
    }
  }

  Widget _rowNotes() {
    return Row(
      children: [
        _chip('All', 0),
        _chip('Important', 1),
        _chip('To Do', 2),
      ],
    );
  }

  Widget _chip(String label, int index) {
    return NoteChip(
      index: index,
      isSelect: isSelected,
      label: label,
      press: () {
        setState(() {
          for (var i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
    );
  }

  Widget _titleNote(BuildContext context) {
    return Row(
      children: [
        Text(
          'My\nNotes',
          style: textTitleStyle.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Image.asset(
          'assets/images/note_lists.png',
          width: 100,
          height: 100,
        ),
        const Spacer(),
        darkMode(context),
      ],
    );
  }

  Widget darkMode(BuildContext context) {
    final cubit = BlocProvider.of<ThemeCubit>(context);
    return IconButton(
      onPressed: () {
        cubit.switchTheme();
      },
      icon: Icon(
        cubit.state == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget showProgressLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
