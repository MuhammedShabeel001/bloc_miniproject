import 'package:bloc_project/application/splash_bloc/splash_bloc.dart';
import 'package:bloc_project/presentation/screens/splash/screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => SplashBloc(),
        child:const SplashScreen(),
      ),
    );
  }
}
