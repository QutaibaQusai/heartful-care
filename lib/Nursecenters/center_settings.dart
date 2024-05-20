import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Nursecenters/center_add_nurse.dart';
import 'package:test/Nursecenters/center_change_email.dart';
import 'package:test/Nursecenters/center_chnage_password.dart';
import 'package:test/Nursecenters/center_information.dart';
import 'package:test/Nursecenters/center_my_nurses.dart';
import 'package:test/Nursecenters/center_requests_history.dart';
import 'package:test/Nursecenters/center_login.dart';

class CenterSettings extends StatefulWidget {
  final String centerEmail;
  final String centerId;

  const CenterSettings({
    super.key,
    required this.centerEmail,
    required this.centerId,
  });

  @override
  State<CenterSettings> createState() => _CenterSettingsState();
}

class _CenterSettingsState extends State<CenterSettings> {
  String centerName = "";
  String? centerProfileImage;
  @override
  void initState() {
    super.initState();
    fetchCenterData();
  }

  void fetchCenterData() async {
    try {
      var centerDoc = await FirebaseFirestore.instance
          .collection('centers')
          .where('Email', isEqualTo: widget.centerEmail)
          .get();

      if (centerDoc.docs.isNotEmpty) {
        var userData = centerDoc.docs[0].data();

        setState(
          () {
            centerProfileImage = userData['centerProfileImage'];
            centerName = userData['Center Name'];
          },
        );
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      centerProfileImage != null
                          ? ClipOval(
                              child: Image.network(
                                centerProfileImage!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png",
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
                            centerName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
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
                    // navigateAndUpdateProfile();
                    // CenterInformation

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CenterInformation(
                            centerEmail: widget.centerEmail)));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        "About Nurses",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                            FontAwesomeIcons.plus,
                            color: Color(0xFF1C8892),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Add Nurse",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          FontAwesomeIcons.chevronRight,
                          color: Color(0xFF1C8892),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CenterAddNurse(
                          centerId: widget.centerId,
                        ),
                      ),
                    );
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
                            FontAwesomeIcons.userNurse,
                            color: Color(0xFF1C8892),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "My Nurses",
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CenterMyNurses(
                          centerId: widget.centerId,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        "About Center",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                            FontAwesomeIcons.history,
                            color: Color(0xFF1C8892),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "History",
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CenterRequestsHistory()));
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
                            FontAwesomeIcons.envelope,
                            color: Color(0xFF1C8892),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Change Email",
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CenterChangeEmail()));
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
                            FontAwesomeIcons.lock,
                            color: Color(0xFF1C8892),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Change Password",
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CenterChangePassword()));
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
                                deleteCenterAccount();
                              },
                              child: Text("Delete"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    );
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
                            FontAwesomeIcons.signOut,
                            color: Color(0xFF1C8892),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Log Out",
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
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(color: Color(0xFF1C8892)), // Change title color
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Color(0xFF1C8892)), // Change content color
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Perform logout action
                // await _clearUserData();

                // Navigate to home page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => CentersLogin()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Yes',
                style: TextStyle(
                    color: Color(0xFF1C8892)), // Change 'Yes' button color
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(
                    color: Color(0xFF1C8892)), // Change 'No' button color
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteCenterAccount() async {
    // Get a reference to the FirebaseAuth instance
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user
    User? user = auth.currentUser;

    try {
      // Delete the user from FirebaseAuth
      await user?.delete();

      // Delete the center from Firestore
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db
          .collection('centers')
          .where('Email', isEqualTo: widget.centerEmail)
          .get()
          .then((snapshot) async {
        for (var doc in snapshot.docs) {
          await db.collection('centers').doc(doc.id).delete();
        }
      });

      // Navigate to the login screen after successful deletion
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CentersLogin()),
        (Route<dynamic> route) => false,
      );

      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Center account successfully deleted.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle errors, for instance, if the user deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete center account: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error deleting center account: $e');
    }
  }
}
