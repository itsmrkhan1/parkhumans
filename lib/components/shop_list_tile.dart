import 'package:flutter/material.dart';

class ShopListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const ShopListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap, required Color color,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}