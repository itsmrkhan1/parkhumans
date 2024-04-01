import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'like_button.dart'; // Ensure this import is correct
import 'package:phproject/components/comment.dart'; // Import Comment widget
import 'package:phproject/components/commentbutton.dart'; // Import CommentButton widget

class MyListTile extends StatefulWidget {
  final String title;
  final String subTitle;
  final String postId;
  final Timestamp timestamp;
  final bool showTimestamp;
  final Color? titleColor;
  final Color? subTitleColor;
  final List<String> likes;

  const MyListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.timestamp,
    required this.postId,
    required this.likes,
    this.showTimestamp = true,
    this.titleColor,
    this.subTitleColor,
  }) : super(key: key);

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  late bool isLiked; // Use late initialization
  late int likeCount; // Use late initialization

  @override
  void initState() {
    super.initState();
    updateLikesInfo();
  }

  void updateLikesInfo() {
    setState(() {
      isLiked = widget.likes.contains(currentUser.email);
      likeCount = widget.likes.length;
    });
  }

  void toggleLike() {
    final userEmail = currentUser.email!; // Asserting that currentUser.email is not null
  
    setState(() {
      if (isLiked) {
        widget.likes.remove(userEmail);
        likeCount--;
      } else {
        widget.likes.add(userEmail);
        likeCount++;
      }
      isLiked = !isLiked; // Toggle the like status
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);
    // Update the 'Likes' field in the Firestore document based on the updated likes list
    postRef.update({'Likes': widget.likes});
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateTime = widget.showTimestamp
        ? DateFormat('MM/dd/yyyy hh:mm a').format(widget.timestamp.toDate())
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
                widget.subTitle,
                style: TextStyle(
                  color: widget.subTitleColor ?? Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.titleColor ?? const Color.fromRGBO(237, 84, 87, 1),
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              if (isLiked)
                likebutton(
                  isLiked: true,
                  onTap: toggleLike,
                )
              else
                GestureDetector(
                  onTap: toggleLike,
                  child: Icon(Icons.rsvp_sharp, size: 40), // Adjust the size of the RSVP icon here
                ),
              
              const SizedBox(height: 10),
              Text(isLiked ? 'Confirmed' : ' '),
              const Icon(Icons.arrow_back),
              const SizedBox(width: 8),
              Text('$likeCount'),
              const SizedBox(width: 8),
               // Pass postId to CommentButton
              const SizedBox(width: 8),
              widget.showTimestamp
                  ? Text(
                      formattedDateTime,
                      style: const TextStyle(
                        color: Color.fromRGBO(146, 143, 143, 1),
                        fontSize: 9,
                      ),
                    )
                  : Container(),
            ],
          ),
          
        ),
      ),
    );
  }
}
