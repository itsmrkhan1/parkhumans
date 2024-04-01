import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:phproject/components/my_drawer.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer ({super.key});

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue, // Change background color to blue
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header
              DrawerHeader(
                // logo
                child: Center(
                    child: Image.asset('images/ParkHumansVector.png',
                    fit: BoxFit.contain,
                    color: Colors.white,
                    width: 155, // Adjust width as needed
                    height: 155, // Adjust height as needed

                     // Adjust the fit based on your requirement
 // Adjust the fit based on your requirement
  ),
),
                ),

                 // Change icon color to white??
                

              // home title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white, // Change icon color to white
                  ),
                  title: const Text(
                    "H O M E",
                    style: TextStyle(color: Colors.white), // Change text color to white
                  ),
                  onTap: () {
                    // this is already the home screen so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // profile title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white, // Change icon color to white
                  ),
                  title: const Text(
                    "P R O F I L E",
                    style: TextStyle(color: Colors.white), // Change text color to white
                  ),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              // users title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.group,
                    color: Colors.white, // Change icon color to white
                  ),
                  title: const Text(
                    "M E M B E R S",
                    style: TextStyle(color: Colors.white), // Change text color to white
                  ),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),

          // Shop Intro tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.star_border,
                    color: Colors.white, // Change icon color to white
                  ),
                  title: const Text(
                    "E X C L U S I V E S",
                    style: TextStyle(color: Colors.white), // Change text color to white
                  ),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/shop_page');
                  },
                ),
              ),
            ],
          ),

          // logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: const Icon(
                Icons.logout, // Changed the icon to logout icon
                color: Colors.white, // Change icon color to white
              ),
              title: const Text(
                "L O G O U T",
                style: TextStyle(color: Colors.white), // Change text color to white
              ),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}