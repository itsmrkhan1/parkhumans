import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateExistingDocuments() async {
  final CollectionReference postsCollection = FirebaseFirestore.instance.collection('User Posts');

  // Get all documents in the collection
  QuerySnapshot snapshot = await postsCollection.get();

  // Iterate over each document
  snapshot.docs.forEach((DocumentSnapshot document) async {
    // Check if the 'likes' field doesn't exist
    if (!document.exists || (document.data() as Map<String, dynamic>?)?['likes'] == null)
 {
      // Update the document to add the 'likes' field initialized as an empty list
      await document.reference.update({'likes': []});
      print('Document ${document.id} updated successfully.');
    } else {
      print('Document ${document.id} already has a likes field.');
    }
  });

  print('All documents updated.');
}

void main() {
  updateExistingDocuments();
}
