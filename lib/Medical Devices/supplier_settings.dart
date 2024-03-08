import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Medical%20Devices/add_device.dart';
import 'package:test/Medical%20Devices/supplierRegistrationPage.dart';
import 'package:test/Medical%20Devices/supplier_profile.dart';

class Suppliers_sittings extends StatelessWidget {
  final String supplierEmail;
  const Suppliers_sittings({super.key, required this.supplierEmail});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUNNBIv06ExHc1ukAR8kBj3xuKlWNOoBMZiAueAxVzj4Dw33zzZPDy1b7EqRUIJSgYrsQ&usqp=CAU",
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Al Khalidi supplers",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("data", style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                    Expanded(child: Container()),
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      color: Color(0xFF1C8892),
                    ),
                  ],
                ),
                onTap: () {
                  //TODO
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Supplier_profile(
                            supplierEmail: supplierEmail,
                          )));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      "Devises",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          FontAwesomeIcons.upload,
                          color: Color(0xFF1C8892),
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Add Devise",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Color(0xFF1C8892),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Add_device(
                            supplierEmail: supplierEmail,
                          )));
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.device_hub_outlined,
                          color: Color(0xFF1C8892),
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "My Devise",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Color(0xFF1C8892),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  //TODO
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      "About Me",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          FontAwesomeIcons.language,
                          color: Color(0xFF1C8892),
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Language",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Color(0xFF1C8892),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  //TODO
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          FontAwesomeIcons.deleteLeft,
                          color: Color(0xFF1C8892),
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Delete Account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Color(0xFF1C8892),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Account"),
                        content: Text(
                            "Are you sure you want to delete your account?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Call method to delete account
                              _deleteAccount();
                              // Close dialog and navigate to login screen
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SupplierRegistration()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    await FirebaseFirestore.instance
        .collection('Suppliers')
        .doc(supplierEmail)
        .delete();

    // Delete Firebase Authentication account
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }
  }
}
