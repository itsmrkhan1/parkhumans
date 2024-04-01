import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phproject/components/my_button.dart';
import 'package:phproject/components/my_textfield.dart';
import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

// register method
Future<void> registeruser() async {
  // show loading circle
  showDialog(
    context: context, 
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  // make sure passwords match
  if (passwordController.text != confirmPwController.text) {
    // pop loading circle
    Navigator.pop(context);
    // show error message to user
    displayMessageToUser("Password doesn't match!", context);
  }

// if password do match
  else {
  // try creating the user
  try {
    // create the user
    UserCredential? userCredential = 
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
    );
    
    // create a user document and add to firestore
    createUserDocument(userCredential);

    //pop loading circle
    if (context.mounted) Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    // pop loading circle
    Navigator.pop(context);

    // display error message to user
    displayMessageToUser(e.code, context);

  }
  }
}

  // create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential !=null && userCredential.user !=null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
            'email': userCredential.user!.email,
            'username': usernameController.text.split('@')[0],
            'bio' : 'Empty bio..' // initially empty bio
            // add any additional fields needed
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          // logo
          Image.asset('images/ph2.png'),
          
          const SizedBox(height: 5),
          
          // app name
          const Text(
            "Register Now!",
            style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 5),

          // username textfield
          MyTextField(
            hintText: "Username", 
            obscureText: false, 
            controller: usernameController,
            ),

            const SizedBox(height: 5),

            // email textfield
          MyTextField(
            hintText: "Email", 
            obscureText: false, 
            controller: emailController,
            ),
            const SizedBox(height: 5),

          // password textfield
           MyTextField(
            hintText: "Password", 
            obscureText: true, 
            controller: passwordController,
            ),

            const SizedBox(height: 5),

            // confirm password textfield
           MyTextField(
            hintText: "Confirm Password", 
            obscureText: true, 
            controller: confirmPwController,
            ),

            const SizedBox(height: 5),

          // forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Forgot Password?", 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ],
          ),

          const SizedBox(height:15),

          // register button
          MyButton(
            text: "Register",
            onTap: registeruser,
          ),

          const SizedBox(height:15),

          // don't have an account? Register here!
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
                ),

              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  "Login here!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
              ),
            ],
          ),
        ],
        ),
      ),
   ),
  );
 }
}