import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:test/Settings/YourAccountInfoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/User%20Settings/YourAccountInfoPage.dart';

class Account extends StatefulWidget {
  final String userEmail;
  final String userName;

  const Account({Key? key, required this.userEmail, required this.userName})
      : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String fullname = "";
  String phoneNumber = ""; // Add this variable for phone number
  String nationalID = ""; // Add this variable for national ID
  DateTime? dateOfBirth; // Add this variable for date of birth
  String? userProfile;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        var userData = userDoc.docs[0].data();

        setState(
          () {
            fullname = userData['fullname'] ?? "";
            phoneNumber = userData['Phone Number'] ?? "";
            nationalID = userData['NationalID'] ?? "";

            // Parse the date string if available
            if (userData['DateOfBirth'] != null) {
              dateOfBirth = DateTime.parse(userData['DateOfBirth']);
            }
            userProfile = userDoc.docs[0]['users_profile'];
          },
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1C8892),
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: CircleAvatar(
        //     radius: 20,
        //     backgroundColor: Colors.white,
        //     child: IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //       color: Color(0xFF1C8892),
        //     ),
        //   ),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Color(0xFF1C8892),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YourAccountInfoPage(
                        userEmail: widget.userEmail,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.0,
                color: Color(0xFF1C8892),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        //color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        // blurRadius: 4,
                        //offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.42,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width /
                                6, // Adjust the radius as needed
                            backgroundImage: userProfile != null
                                ? NetworkImage(userProfile!)
                                : AssetImage("images/profile.webp")
                                    as ImageProvider,
                          ),
                        ),
                        Text(
                          fullname.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [],
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  leading: Icon(Icons.email),
                                  iconColor: Color(0xFF1C8892),
                                  title: Text(
                                    'Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    widget.userEmail.isNotEmpty
                                        ? widget.userEmail
                                        : "Guest",
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  leading: Icon(Icons.call),
                                  iconColor: Color(0xFF1C8892),
                                  title: Text('Phone Number',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(phoneNumber),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  leading: Icon(FontAwesomeIcons.idCard),
                                  iconColor: Color(0xFF1C8892),
                                  title: Text('National ID',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(nationalID),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  leading: Icon(FontAwesomeIcons.calendar),
                                  iconColor: Color(0xFF1C8892),
                                  title: Text('Date of Birth',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                    dateOfBirth != null
                                        ? formatDate(dateOfBirth!,
                                            [dd, '/', mm, '/', yyyy])
                                        : '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
