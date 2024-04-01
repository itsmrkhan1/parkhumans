import 'package:flutter/material.dart';

class PostButton extends StatefulWidget {
  final void Function()? onTap;
  const PostButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _PostButtonState createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Container(
          decoration: BoxDecoration(
            color: _isHovering
                ? const Color.fromRGBO(237, 84, 87, 0.8) // Change color when hovering
                : const Color.fromRGBO(237, 84, 87, 1),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.only(left: 10),
          child: const Center(
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromARGB(255, 240, 237, 237),
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
