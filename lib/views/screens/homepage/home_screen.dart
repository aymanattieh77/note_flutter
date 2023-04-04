import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:todo/controller/notes/cubit/note_cubit.dart';
import 'package:todo/controller/notes/filter_note_cubit/filter_cubit.dart';
import 'package:todo/views/components/note_alert.dart';

import 'package:todo/views/screens/homepage/widgets/empty_note.dart';

import '../note_edit_page/note_edit_screen.dart';

import '../../../controller/theme/theme_cubit.dart';

import '../../../data/models/note.dart';

import '../../components/note_card.dart';
import '../../constants/constants.dart';

import 'widgets/note_float_action_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 150,
          title: _titleNote(context),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: BlocProvider.of<FilterNotesCubit>(context).onTabChange,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Important'),
              Tab(text: 'Todo'),
            ],
          ),
        ),
        body: BlocBuilder<FilterNotesCubit, int>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: blocNote(),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: NoteFloatActionButton(press: goToEditScreen),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget blocNote() {
    final val = BlocProvider.of<FilterNotesCubit>(context).state;
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        if (state is NoteLoaded) {
          notes = state.notes;
          importantNotes =
              notes.where((note) => note.isImportant == 1).toList();
          todoNotes = notes.where((note) => note.isTodo == 1).toList();
          final filterNotes = val == 0
              ? notes
              : val == 1
                  ? importantNotes
                  : todoNotes;
          return notes.isNotEmpty ? noteList(filterNotes) : const EmptyNote();
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
      ),
    );
  }

  Widget noteList(List<Note> notes) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
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
