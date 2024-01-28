import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAddressPage extends StatefulWidget {
  final String userEmail;

  const AddAddressPage({super.key, required this.userEmail});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch the user's name when the widget is created
  }

  void fetchUserData() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        var userData = userDoc.docs[0].data();

        setState(() {
          areaController.text = userData['Area'] ?? "";
          addressnicknameController.text = userData['Address nickname'] ?? "";
          streetController.text = userData['Street'] ?? "";
          buildingController.text = userData['Building'] ?? "";
          floorController.text = userData['Floor'] ?? "";
          apartmentController.text = userData['Apartment'] ?? "";
          mobilenumController.text = userData['Mobile number'] ?? "";
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

  TextEditingController areaController = TextEditingController();
  TextEditingController addressnicknameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();

  //FirebaseAuth _auth = FirebaseAuth.instance;
  /*void _saveAddressData() async {
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
  }*/

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
                _showDeleteConfirmationDialog();
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
                    _submitUserData();
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

  Future<void> _submitUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Find the user document
      var userDoc =
          await users.where('email', isEqualTo: widget.userEmail).get();

      if (userDoc.docs.isNotEmpty) {
        var userId = userDoc.docs[0].id;

        // Update the existing document with the new data
        await users.doc(userId).update({
          'Area': areaController.text,
          'Address nickname': addressnicknameController.text,
          'Street': streetController.text,
          'Building': buildingController.text,
          'Floor': floorController.text,
          'apartment': apartmentController.text,
          'Mobile number': mobilenumController.text
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              ' User data updated successfully!',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'User not found',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Error updating user data: $e',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }

  // this method is to detete the address inforamtion from the firestore and clear the text boxes
  void _deleteUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Find the user document
      var userDoc =
          await users.where('email', isEqualTo: widget.userEmail).get();

      if (userDoc.docs.isNotEmpty) {
        var userId = userDoc.docs[0].id;

        // Update the document in Firestore by setting specific fields to null
        await users.doc(userId).update({
          'Area': FieldValue.delete(),
          'Address nickname': FieldValue.delete(),
          'Street': FieldValue.delete(),
          'Building': FieldValue.delete(),
          'Floor': FieldValue.delete(),
          'apartment': FieldValue.delete(),
          'Mobile number': FieldValue.delete(),
        });

        // Clear the text field values
        setState(() {
          areaController.text = '';
          addressnicknameController.text = '';
          streetController.text = '';
          buildingController.text = '';
          floorController.text = '';
          apartmentController.text = '';
          mobilenumController.text = '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Address information deleted successfully!',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'User not found',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Error deleting address information: $e',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }

  // show alert dialog to ask the user if he really want to delete the data
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Address Information",
            style: TextStyle(fontSize: 20, color: Color(0xFF1C8892)),
          ),
          content:
              Text("Are you sure you want to delete this address information?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "No",
                style: TextStyle(color: Color(0xFF1C8892)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteUserData(); // Call the delete function
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Color(0xFF1C8892)),
              ),
            ),
          ],
        );
      },
    );
  }
}
