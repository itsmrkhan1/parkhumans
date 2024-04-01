import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:const Color.fromARGB(255, 255, 200, 200),
          borderRadius: BorderRadius.circular(5)
        ),
        padding:const EdgeInsets.all(5),
        child: Center(
          child: Text( 
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white
            ),
          ),),
      )


    );
  }
}