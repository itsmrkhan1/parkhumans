import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comment extends StatefulWidget {
  final String postId;

  const Comment({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController _commentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (widget.postId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Post ID is empty.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .doc(widget.postId)
                  .collection('postComments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No comments yet.'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var commentData = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(commentData['comment']),
                      subtitle: Text(commentData['user']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_commentController.text.trim().isNotEmpty) {
                      var currentUser = _auth.currentUser;
                      if (currentUser != null) {
                        await FirebaseFirestore.instance
                            .collection('comments')
                            .doc(widget.postId)
                            .collection('postComments')
                            .add({
                          'comment': _commentController.text.trim(),
                          'user': currentUser.email,
                          'timestamp': Timestamp.now(),
                        });
                        _commentController.clear();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
