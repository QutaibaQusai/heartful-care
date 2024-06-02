import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/User%20Settings/YourAccountInfoPage.dart';
import 'package:test/User%20Settings/YourChangeEmailPage.dart';
import 'package:test/User%20Settings/YourChangePassPage.dart';
import 'package:test/User%20Settings/addaddresspage.dart';
import 'package:test/intro_page.dart';
import 'package:test/provider/myprovider.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
       

        centerTitle: true,
        title: Text(
          'Settings ',
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
            buildAccountOption(context, "Your Address"),
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
          
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.language, "Language"),
            buildLanguageOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
        
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
          Navigator.push(
              context,
              _createRightToLeftRoute(
                  YourAccountInfoPage(userEmail: widget.userEmail)));
        }
        if (title == "Change Email") {
          Navigator.push(
              context,
              _createRightToLeftRoute(
                  YourChangeEmailPage(userEmail: widget.userEmail)));
        }
        if (title == "Your Address") {
          Navigator.push(
              context,
              _createRightToLeftRoute(
                  AddAddressPage(userEmail: widget.userEmail)));
        }
        if (title == "Change Password") {
          Navigator.push(
              context, _createRightToLeftRoute(YourChangePassPage()));
        }
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .delete();

    // Delete Firebase Authentication account
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }
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
    // delete saved data .
    await context.read<MyProvider>().DeleteSavedUserLogin();

    // go back to inro page
    Navigator.pushReplacement(context,
        PageTransition(child: IntroPage(), type: PageTransitionType.fade));
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

  Route _createRightToLeftRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
