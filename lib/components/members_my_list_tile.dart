import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class membersmylisttile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Timestamp timestamp;
  final bool showTimestamp; // New parameter to control showing the timestamp
  final Color? titleColor; // New parameter for title color
  final Color? subTitleColor; // New parameter for subtitle color

  const membersmylisttile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.timestamp,
    this.showTimestamp = true, // Default value is true to show timestamp
    this.titleColor, // Nullable parameter for title color
    this.subTitleColor, // Nullable parameter for subtitle color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format timestamp if requested
    String formattedDateTime = showTimestamp
        ? DateFormat('MM/dd/yyyy hh:mm a').format(timestamp.toDate())
        : '';

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 221, 0, 0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: TextStyle(
                  color: subTitleColor ?? Colors.black, // Use provided color or default to black
                  fontWeight: FontWeight.bold, // Make subtitle bold
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: titleColor ?? const Color.fromRGBO(237, 84 , 87, 1), // Use provided color or default to black
                ),
              ),
            ],
          ),
          subtitle: showTimestamp
              ? Align(
                  alignment: Alignment.topRight, // Align timestamp to top right
                  child: Text(
                    formattedDateTime,
                    style: const TextStyle(
                      color: Color.fromRGBO(146, 143, 143, 1),
                      fontSize: 9, // Smaller font size
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
