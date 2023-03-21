import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/controller/notes/cubit/note_cubit.dart';
import 'package:todo/controller/simple_bloc_observer.dart';
import 'package:todo/controller/theme/theme_cache.dart';
import 'package:todo/data/database/note_database.dart';

import 'controller/theme/theme_cubit.dart';

import 'views/constants/theme.dart';
import 'views/screens/homepage/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase().database;
  Bloc.observer = SimpleBlocObserver();
  bool isDark = await ThemeCache().getTheme() ?? false;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (ctx) => NoteCubit(),
      ),
      BlocProvider(
        create: (ctx) => ThemeCubit(isDark ? ThemeMode.dark : ThemeMode.light),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state,
          home: const HomeScreen(),
        );
      },
    );
  }
}
