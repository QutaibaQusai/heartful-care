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
  final String centerName;
  final String centerId;
  final String centerProfileImage;
  const CenterSettings({
    super.key,
    required this.centerEmail,
    required this.centerName,
    required this.centerId,
    required this.centerProfileImage,
  });

  @override
  State<CenterSettings> createState() => _CenterSettingsState();
}

class _CenterSettingsState extends State<CenterSettings> {
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
                      widget.centerProfileImage.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                widget.centerProfileImage,
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
                            widget.centerName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          //Text("data", style: TextStyle(color: Colors.grey[700])),
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
                        builder: (context) => CenterAddAndUpdateNurseInfo(
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
                                // Call method to delete account
                                // _deleteAccount();
                                // Close dialog and navigate to login screen
                                // Navigator.of(context).pushAndRemoveUntil(
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           SupplierRegistration()),
                                //   (Route<dynamic> route) => false,
                                // );
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
}
