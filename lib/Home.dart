import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/Profile/account.dart';
import 'package:test/User%20Settings/settings_home_page.dart';
import 'package:test/model/Home_Sections_Model.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/supplierMedicalSuppliers.dart';
import 'package:test/sections/NurseCenterSection/nurse_centersTils.dart';

class Home extends StatefulWidget {
  final String userEmail;
  const Home({Key? key, required this.userEmail});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<MyProvider>().GetUserlogin();
    super.initState();
    if (widget.userEmail.isNotEmpty) {
      context.read<MyProvider>().getUserInfo(userEmail: widget.userEmail);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final isGuest = widget.userEmail.isEmpty;
    double screenWidth = MediaQuery.of(context).size.width;

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
              ),
              Column(
                children: [
                  Container(
                    width: screenWidth,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF1C8892),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<MyProvider>(
                                builder: (context, value, child) {
                                  final userInfo = value.userInfo;
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Account(
                                                userEmail: widget.userEmail,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: screenWidth / 18,
                                          backgroundImage: isGuest
                                              ? AssetImage(
                                                  "images/profile.webp")
                                              : (userInfo != null &&
                                                          userInfo
                                                              .userImage.isNotEmpty
                                                      ? NetworkImage(
                                                          userInfo.userImage)
                                                      : AssetImage(
                                                          "images/profile.webp"))
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
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            isGuest
                                                ? "Guest"
                                                : userInfo?.userName ?? '',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.045,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
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
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            "How are you feeling \ntoday?",
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.search,
                                  size:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
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
                          )
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
              ),
            ],
          ),
          bottomNavigationBar: TabBar(
            labelColor: Color(0xFF1C8892),
            labelStyle: GoogleFonts.poppins(),
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: screenWidth * 0.05, // Responsive icon size
                ),
                iconMargin: EdgeInsets.only(bottom: 8),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive text size
                  ),
                ),
              ),
              Tab(
                icon: Image.asset(
                  "images/logo2.png",
                  width: screenWidth * 0.08, // Responsive image width
                ),
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive text size
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.gear,
                  size: screenWidth * 0.05, // Responsive icon size
                ),
                iconMargin: EdgeInsets.only(bottom: 8),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive text size
                  ),
                ),
              ),
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: screenWidth * 0.9,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              sections.sectionImage,
              width: screenWidth * 0.3,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    sections.sectionName,
                    style: TextStyle(
                      color: Color(0xFF1C8892),
                      fontSize: screenWidth * 0.05,
                      fontFamily: GoogleFonts.titilliumWeb().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    sections.sectionDis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.030,
                      color: Colors.grey[700],
                    ),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      if (sections.sectionName == "Nurse Centers") {
                        // Navigator.push(
                        //   context,
                        //   _createRightToLeftRoute(
                        //     NurseCenters(userEmail: widget.userEmail),
                        //   ),
                        // );
                        Navigator.push(
                            context,
                            PageTransition(
                                child:
                                    NurseCenters(userEmail: widget.userEmail),
                                type: PageTransitionType.fade));
                      } else if (sections.sectionName == "Medical Devices") {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: SupplierMedicalSupplier(
                                    userEmail: widget.userEmail),
                                type: PageTransitionType.fade));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'See More',
                          style: TextStyle(
                            color: Color(0xFF1C8892),
                            fontSize: screenWidth * 0.035,
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
            ),
          ],
        ),
      ),
    );
  }
}
