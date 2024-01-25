import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController areaController = TextEditingController();
  TextEditingController addressnicknameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _saveAddressData() async {
    // Get the current user
    User? user = _auth.currentUser;

    if (user != null) {
      // Create a reference to the user's document in Firestore
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Create a map with the address data
      Map<String, dynamic> addressData = {
        'area': areaController.text,
        'addressNickname': addressnicknameController.text,
        'street': streetController.text,
        'building': buildingController.text,
        'floor': floorController.text,
        'apartment': apartmentController.text,
        'mobileNumber': mobilenumController.text,
      };

      // Set the data at the user's document ID
      await userDocRef.set(addressData);

      // Optionally, you can navigate to another screen or show a success message
    } else {
      // Handle the case when the user is not authenticated
      print('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit address',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Handle delete action here
                // You can show a confirmation dialog or perform the delete operation
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Your existing page content goes here

              // Add the "area" text field with underline
              TextField(
                controller: areaController,
                decoration: InputDecoration(
                  labelText: 'Area',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: streetController,
                decoration: InputDecoration(
                  labelText: 'Address Nickname',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: buildingController,
                decoration: InputDecoration(
                  labelText: 'Street',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: addressnicknameController,
                decoration: InputDecoration(
                  labelText: 'Building',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: floorController,
                decoration: InputDecoration(
                  labelText: 'Floor',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: apartmentController,
                decoration: InputDecoration(
                  labelText: 'Apartment',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: mobilenumController,
                decoration: InputDecoration(
                  labelText: 'Mobile number',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50, // Set the height of the button
                child: ElevatedButton(
                  onPressed: () {
                    _saveAddressData();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                    primary: Color(0xFF1C8892), // Background color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text('Save address'),
                ),
              ),
              // Add more widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}
