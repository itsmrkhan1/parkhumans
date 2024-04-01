import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phproject/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

    @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => HomePage(),
        ));
    });
  }
@override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          
          child: Column(
            children: [
              const SizedBox(height: 150),
              // logo
            Image.asset('images/ph2.png'),
            
            const SizedBox(height: 15),
            
            // app name
            const Text(
              "A New Adventure Awaits!",
              style: TextStyle(fontSize: 20),
              ),
          
              const SizedBox(height: 10),
              
                
            ],
          ),
        )
      ),
    );
  }
}