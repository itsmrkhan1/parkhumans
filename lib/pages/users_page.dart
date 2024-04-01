import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/members_my_list_tile.dart';
import '../helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "M E M B E R S",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 1,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 1)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              displayMessageToUser("Something went wrong", context);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final users = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      String username = user['username'] ?? ''; // Get username or assign empty string if it's null
                      String pupsName = user.data().containsKey('pupsName') ? user['pupsName'] : ''; // Check if 'pupsName' exists, if not, assign empty string
                      String breed = user.data().containsKey('breed') ? user['breed'] : ''; // Check if 'breed' exists, if not, assign empty string
                      
                      // Print document snapshot for debugging
                      print(user.data());

                      return membersmylisttile(
                        title: username,
                        subTitle: '$pupsName - $breed', // Assign pupsName and breed to subTitle
                        timestamp: Timestamp.now(), showTimestamp: false, // Don't display timestamp
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
