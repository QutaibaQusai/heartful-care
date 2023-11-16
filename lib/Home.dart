import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import for CupertinoIcons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test/model/sections.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final items = const [
    Icon(
      FontAwesomeIcons.user,
      size: 30,
    ),
    ImageIcon(
      AssetImage("images/logoo.png"),
      size: 35,
    ),
    Icon(
      FontAwesomeIcons.gear,
      size: 30,
    )
  ];
  int index = 1;

  // list of object
  List<Sections> mySectionList = [
    Sections(
        sectionImage: "images/nurse-card-home.png",
        sectionName: "Nurse centers",
        sectionDis:
            "Access professional nursing \ncare right at your doorstep."),
    Sections(
        sectionImage:
            "images/WhatsApp_Image_2023-11-03_at_19.30.49_c6ac0fb0-removebg-preview-removebg-preview.png",
        sectionName: "Medical devices",
        sectionDis:
            "Explore our comprehensive range\n of medical devices available \nfor purchase or rent."),

    //   Sections(
    //       sectionImage: "images/24.jpg",
    //       sectionName: "Medical devices",
    //       sectionDis:
    //           "Explore our comprehensive range of medical devices available for purchase\n or rent.")
    //
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                color: Color(0xFF1C8892),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage("images/logo2.png"),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  greeting(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey, // Change as needed
                                  ),
                                ),
                                Text(
                                  "Sarah Abu Zaid",
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
                    Text("  ")
                  ],
                ),
              ),
            ),
            // Text("data")
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
      ),
      bottomNavigationBar: bottonNav(),
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

  Widget bottonNav() {
    return CurvedNavigationBar(
      items: items,
      index: index,
      height: 55,
      buttonBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      color: Color(0xFF1C8892),
      //0xFF1C8892
      onTap: (selectedIndex) {
        setState(() {
          index = selectedIndex;
        });
      },
    );
  }

  Widget tile(Sections sections) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print("object");
          },
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
                        fontSize: 24,
                        fontFamily: GoogleFonts.titilliumWeb().fontFamily,
                        height: 1.9,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sections.sectionDis,
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
