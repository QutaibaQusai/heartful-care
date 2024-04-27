import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test/Profile/account.dart';
import 'package:test/User%20Settings/settings_home_page.dart';
import 'package:test/model/Home_Sections_Model.dart';
import 'package:test/sections/MedicalDevicesSection/medicalSuppliers.dart';
import 'package:test/sections/NurseCenterSection/nurse_centersTils.dart';

class Home extends StatefulWidget {
  final String userEmail;
  const Home({Key? key, required this.userEmail});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userProfile;

  String userName = ""; // Store the user's name
  @override
  void initState() {
    super.initState();
    fetchUserName(); // Fetch the user's name when the widget is created
  }

  void fetchUserName() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        setState(() {
          userName = userDoc.docs[0]['fullname'];
          userProfile = userDoc.docs[0]['users_profile'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // list of object
  List<Sections> mySectionList = [
    Sections(
        sectionImage: "images/nurse-card-home.png",
        sectionName: "Nurse Centers",
        sectionDis:
            "Access professional nursing \ncare right at your doorstep."),
    Sections(
        sectionImage:
            "images/WhatsApp_Image_2023-11-03_at_19.30.49_c6ac0fb0-removebg-preview-removebg-preview.png",
        sectionName: "Medical Devices",
        sectionDis:
            "Explore our comprehensive range\n of medical devices available \nfor purchase or rent."),
  ];
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Account(
                userEmail: widget.userEmail,
                userName: userName,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF1C8892),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Account(
                                            userEmail: widget.userEmail,
                                            userName: userName,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width /
                                              18, // Adjust the radius as needed
                                      backgroundImage: userProfile != null
                                          ? NetworkImage(userProfile!)
                                          : AssetImage("images/profile.webp")
                                              as ImageProvider,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        greeting(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.grey, // Change as needed
                                        ),
                                      ),
                                      Text(
                                        userName.isNotEmpty
                                            ? userName
                                            : "Guest",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              CircleAvatar(
                                radius: 20,
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Iconsax.notification,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            "How are you feeling \ntoday?",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(FontAwesomeIcons.search),
                                SizedBox(width: 8),
                                Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: 'Search here',
                                      border: InputBorder.none,
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: mySectionList.length,
                      itemBuilder: (context, index) {
                        return tile(mySectionList[index]);
                      },
                    ),
                  ),
                ],
              ),
              SettingFirstPage(
                userEmail: widget.userEmail,
              )
            ],
          ),
          bottomNavigationBar: TabBar(
            labelColor: Color(0xFF1C8892),
            labelStyle: GoogleFonts.poppins(),
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                text: " Profile",
                icon: Icon(FontAwesomeIcons.user),
                iconMargin: EdgeInsets.only(bottom: 8),
              ),
              Tab(
                text: "Home",
                icon: Image.asset(
                  "images/logo2.png",
                  width: 35,
                ),
              ),
              Tab(
                text: "Settings",
                icon: Icon(FontAwesomeIcons.gear),
                iconMargin: EdgeInsets.only(bottom: 8),
              )
            ],
          ),
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Widget tile(Sections sections) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              sections.sectionImage,
              width: 100,
            ),
            Column(
              children: [
                Text(
                  sections.sectionName,
                  style: TextStyle(
                      color: Color(0xFF1C8892),
                      fontSize: 24,
                      fontFamily: GoogleFonts.titilliumWeb().fontFamily,
                      height: 1.9,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  sections.sectionDis,
                  style: TextStyle(
                    fontSize: 12.6,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    if (sections.sectionName == "Nurse Centers") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NurseCenters(
                                userEmail: widget.userEmail,
                              )));
                    } else if (sections.sectionName == "Medical Devices") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Medical(
                                userEmail: widget.userEmail,
                              )));
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'See More',
                        style: TextStyle(
                          color: Color(0xFF1C8892),
                          fontSize: 13,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF1C8892),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
