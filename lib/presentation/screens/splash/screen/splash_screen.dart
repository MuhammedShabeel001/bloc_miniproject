import 'package:bloc_project/application/splash_bloc/splash_bloc.dart';
import 'package:bloc_project/application/splash_bloc/splash_state.dart';
import 'package:bloc_project/presentation/screens/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedLoginState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const HomeScreen()));
          }
        },
        child: const Scaffold(
          body: Center(
            child: SizedBox(
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballTrianglePathColoredFilled,
                colors: [
                  Colors.black,
                  Colors.amberAccent,
                  Colors.deepOrangeAccent
                ],
              ),
            ),
          ),
        ));
  }
}
