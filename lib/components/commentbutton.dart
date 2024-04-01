import 'package:flutter/material.dart';
import 'package:phproject/components/comment.dart';

class CommentButton extends StatelessWidget {
  final String postId;

  const CommentButton({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show a dialog box when the comment button is pressed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white, // Set background color
              title: Text(
                'Add Comment',
                style: TextStyle(color: Colors.black), // Set title color
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Set width
                child: Comment(postId: postId), // Use Comment widget as content
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.blue), // Set button text color
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.comment),
    );
  }
}
