import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late TextEditingController _pupsNameController;
  List<String> _selectedTemperaments = [];
  late TextEditingController _bioController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _pupsNameController = TextEditingController();
    _bioController = TextEditingController();
    _breedController = TextEditingController();
    _ageController = TextEditingController();

    // Fetch user details and initialize temperament
    getUserDetails().then((userDetails) {
      if (userDetails.exists) {
        setState(() {
          _pupsNameController.text = userDetails.data()?['pupsName'] ?? '';
          _bioController.text = userDetails.data()?['bio'] ?? '';
          _breedController.text = userDetails.data()?['breed'] ?? '';
          _ageController.text = userDetails.data()?['age'] ?? '';
          _selectedTemperaments = List<String>.from(userDetails.data()?['temperament'] ?? []);
        });
      }
    });
  }

  @override
  void dispose() {
    _pupsNameController.dispose();
    _bioController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email!).update({
        'pupsName': _pupsNameController.text,
        'breed': _breedController.text,
        'age': _ageController.text,
        'temperament': _selectedTemperaments,
        'bio': _bioController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes saved successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to save changes')));
      print("Error updating user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "P R O F I L E",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 1)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.person,
                size: 64,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                currentUser?.email ?? '', // Use null-aware operator and provide a default value
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Center(
              child: Text(
                currentUser?.displayName ?? '', // Use null-aware operator and provide a default value
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Center(
              child: Text(
                'My Details',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            _buildMyTextBox('Pups Name', _pupsNameController),
            _buildMyTextBox('Breed', _breedController),
            _buildMyTextBox('Age', _ageController),
            _buildCheckboxList('Temperament', _selectedTemperaments, [
              // Choice chip items...
              'excitable',
              'hyper-attached',
              'anxious',
              'fearful',
              'aloof',
              'predatory',
              'reactive',
              'assertive',
              'calm',
              'agreeable',
              "special needs",
              "couch potato",
            ]),
            _buildMyTextBox('Bio', _bioController),
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email!).get();
  }

  Widget _buildMyTextBox(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MyTextBox(
        text: label,
        sectionName: label,
        controller: controller,
      ),
    );
  }

  Widget _buildCheckboxList(String label, List<String> selectedValues, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Column(
            children: items.map((item) {
              return CheckboxListTile(
                title: Text(item),
                value: selectedValues.contains(item),
                onChanged: (selected) {
                  setState(() {
                    if (selected != null && selected) {
                      _selectedTemperaments.add(item);
                    } else {
                      _selectedTemperaments.remove(item);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final TextEditingController? controller;
  final VoidCallback? onPressed;

  const MyTextBox({required this.text, required this.sectionName, this.controller, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.grey[200],
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (controller != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter $sectionName',
                      ),
                   
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
