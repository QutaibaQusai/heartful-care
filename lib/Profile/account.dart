import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Settings/YourAccountInfoPage.dart';

class Account extends StatefulWidget {
  final String userEmail;
  final String userName;
  const Account({super.key, required this.userEmail, required this.userName});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
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
            fontSize: 22,
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),

        centerTitle: true, // Center the title
        backgroundColor: Color(0xFF1C8892),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => Home(userEmail:"" )));
              },
              color: Color(0xFF1C8892),
            ),
          ),
        ),

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
                        builder: (context) => const YourAccountInfoPage(userEmail: '',)),
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
                height: MediaQuery.of(context).size.height / 4.0,
                color: Color(0xFF1C8892),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 1), // changes position of shadow
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
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("images/profile.webp"),
                          ),
                        ),
                        Text(
                          widget.userName.isNotEmpty
                              ? widget.userName
                              : "Guest",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily),
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
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: Icon(Icons.email),
                                    iconColor: Color(0xFF1C8892),
                                    title: Text('Email'),
                                    subtitle: Text(
                                      widget.userEmail.isNotEmpty
                                          ? widget.userEmail
                                          : "Guest",
                                    ),
                                  )),
                              Card(
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: Icon(Icons.call),
                                    iconColor: Color(0xFF1C8892),
                                    title: Text('Phone Number'),
                                    subtitle: Text(''),
                                  )),
                              Card(
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: Icon(FontAwesomeIcons.idCard),
                                    iconColor: Color(0xFF1C8892),
                                    title: Text('National ID'),
                                    subtitle: Text(''),
                                  )),
                              Card(
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: Icon(FontAwesomeIcons.calendar),
                                    iconColor: Color(0xFF1C8892),
                                    title: Text('Data of birth'),
                                    subtitle: Text(''),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
