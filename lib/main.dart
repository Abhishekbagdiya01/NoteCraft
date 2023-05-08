import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_note_app/bloc/notes_bloc.dart';
import 'package:firebase_note_app/screens/splash_screen/splash_screen.dart';
import 'package:firebase_note_app/screens/user_onboarding/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => NotesBloc(),
      ),
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
