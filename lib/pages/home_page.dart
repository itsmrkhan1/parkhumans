import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phproject/components/my_drawer.dart';
import 'package:phproject/components/my_textfield.dart';
import '../components/my_list_tile.dart';
import '../components/my_posts_button.dart';
import '../database/firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirestoreDatabase database;
  late TextEditingController newPostController;
  late String currentUserEmail; // Store current user's email

  @override
  void initState() {
    super.initState();
    database = FirestoreDatabase();
    newPostController = TextEditingController();

    // Retrieve current user's email
    currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    // Call your dialog function here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialogBox();
    });
  }

  // Function to show dialog box
  void showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color here
          title: const Text("Welcome to ParkHumans"),
          content: const Text("Exclusive Events coming soon!!!"),
          
          actions: <Widget>[
            TextButton(
              child: const Text("Lets Walk"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // post message
  void postMessage() {
    // only post message if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set scaffold background to transparent
      appBar: AppBar(
        title: const Text(
          "T H E P A R K",
          style: TextStyle(color: Colors.white), // Change title text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 0, 136, 255), // Change AppBar color to blue
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 1)),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/Park_Background.jpg'), // Replace with your image path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop), // Add transparency here (adjust opacity as needed)
          ),
        ),
        child: Column(
          children: [
            // Textfield box for users to type (visible only for the allowed user)
            if (currentUserEmail == 'parkhumans@parkhumans.com')
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    // textfield
                    Expanded(
                      child: MyTextField(
                        hintText: "Welcome to ParkHumans! Say Hi...",
                        obscureText: false,
                        controller: newPostController,
                      ),
                    ),

                    // posts button
                    PostButton(
                      onTap: postMessage,
                    )
                  ],
                ),
              ),

            // posts
            StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                // show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final posts = snapshot.data!.docs;

                // no data?
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No posts.. Exclusive Events Coming Soon!"),
                    ),
                  );
                }

                // return as a list
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // get each individual post
                      final post = posts[index];

                      // get data from each post
                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];

                      // Extract username from email
                      String username = userEmail.split('@')[0];

                      //return as a list tile
                      return MyListTile(
                        title: message,
                        subTitle: username,
                        timestamp: timestamp, likes: [], postId: '',
                        
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    newPostController.dispose();
    super.dispose();
  }
}
