import 'package:chat/Screens/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/App cubit/app_cubit.dart';
import 'firebase_options.dart';

import 'Screens/Sign up/Sign Up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: LoginScreen()),
    );
  }
}
