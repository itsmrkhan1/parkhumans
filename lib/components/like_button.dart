import "package:flutter/material.dart";

class likebutton extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  likebutton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onTap,
      child: Icon(
        isLiked ? Icons.rsvp: Icons.rsvp_outlined, size: 40,
        color: isLiked ? Colors.red : Colors.white,
        ),
      
      );
  }
}