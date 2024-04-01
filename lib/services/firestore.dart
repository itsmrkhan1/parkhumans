import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // Add a new note to Firestore
  Future<void> addNote(String note, String userEmail, Timestamp timestamp, List<String> likes) async {
    String postId = FirebaseFirestore.instance.collection('notes').doc().id; // Generate unique postId
    await notes.doc(postId).set({
      'postId': postId, // Save postId in the document
      'note': note,
      'userEmail': userEmail,
      'timestamp': timestamp,
      'likes': likes, // Pass likes associated with this postId
    });
  }

  // Update likes for a specific note by postId
  Future<void> updateLikes(String postId, List<String> updatedLikes) {
    return notes.doc(postId).update({'likes': updatedLikes});
  }

  // READ: get notes from database

  // DELETE: delete notes given a doc id
}
