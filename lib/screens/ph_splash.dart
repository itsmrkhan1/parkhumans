import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phproject/pages/home_page.dart';
import 'package:page_transition/page_transition.dart';

class PHsplashScreen extends StatelessWidget {
  const PHsplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:  Lottie.asset('images/Park_Humans_Anime.json'),
      backgroundColor: Colors.white,
      nextScreen: HomePage(),
      splashIconSize: 350,
      duration: 6000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}