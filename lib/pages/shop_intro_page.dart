import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class IntroPage extends StatelessWidget {
  final void Function()? onTap;
  const IntroPage
({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(Icons.star_border,
              size: 72,
              color: Colors.white,
              ),
                
              SizedBox(height: 25),
                
              // title
              Text("Exclusives",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
                
              SizedBox(height: 10),
                
              // subtitle
              Text(".",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
                
              SizedBox(height: 25),
                
              // button
              
              
            ],
          ),
        ),
      );
  }
}