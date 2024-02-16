import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Home.dart';
import 'package:test/User%20Settings/YourAccountInfoPage.dart';
import 'package:test/User%20Settings/YourChangeEmailPage.dart';
import 'package:test/User%20Settings/YourChangePassPage.dart';
import 'package:test/User%20Settings/addaddresspage.dart';
import 'package:test/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingFirstPage extends StatefulWidget {
  final String userEmail;

  const SettingFirstPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SettingFirstPage> createState() => _SettingFirstPage();
}

class _SettingFirstPage extends State<SettingFirstPage> {
  bool notification1 = true;
  bool notification2 = false;
  String selectedLanguage = 'English';
  String selectedLocation = 'Not set';
  List<String> ammanAreas = [
    'Dair Ghbar',
    'Sweileh',
    'Abdoun',
    'Khalda',
    'Rabyeh',
    'Om al somaq',
    'Daheyet Al Rashed',
  ];

  String? get userEmail => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            buildSectionHeader(Icons.person, "Account"),
            buildAccountOption(context, "Account Info"),
            SizedBox(height: 5),
            buildAccountOption(context, "Saved Addresses"),
            SizedBox(height: 5),
            buildAccountOption(context, "Change Email"),
            SizedBox(height: 5),
            buildAccountOption(context, "Change Password"),
            SizedBox(height: 5),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.notifications, "Notifications"),
            buildNotificationOption(context, "News for you", notification1,
                (value) => setState(() => notification1 = value)),
            // buildNotificationOption(context, "App updates", notification2,
            //(value) => setState(() => notification2 = value)),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.language, "Language"),
            buildLanguageOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            // buildSectionHeader(Icons.location_on, "Location"),
            // buildLocationOption(context),
            // Divider(height: 20, thickness: 0.5),
            // SizedBox(height: 10),
            buildSectionHeader(Icons.delete, "Delete account"),
            buildDeleteOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.exit_to_app, "Logout"),
            buildLogoutOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color(0xFF1C8892),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  InkWell buildAccountOption(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        if (title == "Account Info") {
          // Navigate to the desired page (replace YourAccountInfoPage with the actual page class)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => YourAccountInfoPage(
                      userEmail: widget.userEmail,
                    )),
          );
        }
        if (title == "Change Email") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => YourChangeEmailPage()),
          );
        }
        if (title == "Saved Addresses") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddAddressPage(
                      userEmail: widget.userEmail,
                    )),
          );
        }
        if (title == "Change Password") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => YourChangePassPage()),
          );
        } else {}
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationOption(BuildContext context, String title, bool value,
      Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF1C8892),
            //inactiveColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'English';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('English'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'Arabic';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Arabic'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLanguageOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLanguageDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLanguage,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      ),
    );
  }

  /*Future<void> _showLocationInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Location',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            children: ammanAreas
                .map((area) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLocation = area;
                        });
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Text(
                          area,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Widget buildLocationOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLocationInputDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLocation,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.edit_location, color: Colors.black),
          ],
        ),
      ),
    );
  }*/

  Widget buildDeleteOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDeleteDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delete account',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.delete, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete account'),
          content: Text('Are you sure you want to delete the account?'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                // Perform delete account action
                await _deleteAccount();

                // Navigate to home page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => IntroPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    // Delete Firestore document
    // Replace 'users' with the actual collection name in your Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .delete();

    // Delete Firebase Authentication account
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }

    // Clear any local data if necessary
    // ...

    // You might want to sign out from Firebase if you're using Firebase Authentication
    // FirebaseAuth.instance.signOut();
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () async {
                // Perform logout action
                await _clearUserData();

                // Navigate to home page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => IntroPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

// Function to clear user data
  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear relevant user data, for example:
    prefs.remove('userEmail');
    prefs.remove('fullname');
    // Add any other data you want to clear

    // You might also want to sign out from Firebase if you're using Firebase Authentication
    // FirebaseAuth.instance.signOut();
  }

  Widget buildLogoutOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLogoutDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.logout, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
