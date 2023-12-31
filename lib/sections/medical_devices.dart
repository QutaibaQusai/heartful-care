import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Medical extends StatefulWidget {
  @override
  State<Medical> createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  String? selectedLocation;
  TextEditingController searchController = TextEditingController();
  int currentPage = 0;

  // List of location options
  final List<String> locationOptions = ['Amman, Jordan', 'Irbid', 'Madaba'];

  @override
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.75,
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
                          Text(
                            'Location',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors
                                    .white, // Change the color of the location icon
                              ),
                              SizedBox(width: 8),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  setState(() {
                                    selectedLocation = value;
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  return locationOptions.map((String option) {
                                    return PopupMenuItem<String>(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      selectedLocation ?? 'Select Location',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color:
                                    Colors.white, // Set the border color here
                              ),
                              color:
                                  Colors.white, // Set the background color here
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.search,
                                    color:
                                        Colors.black, // Set the icon color here
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: TextField(
                                      controller: searchController,
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Set the text color here
                                      ),
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        hintText: 'Search here',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Special Offer',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Swipeable Box
                  Container(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView(
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          children: [
                            // Page 1
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Best in price',
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Change text color to contrast with white background
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Lottie.asset(
                                    'images/lottie/Animation - 1703503597422.json',
                                  ),
                                ],
                              ),
                            ),
                            // Page 2
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Very Quick delivary',
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Change text color to contrast with white background
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/image1.png', // Change to your image path
                                    height: 80,
                                    width: 80,
                                  ),
                                ],
                              ),
                            ),
                            // Add more pages as needed
                          ],
                        ),
                        // Dots
                        Positioned(
                          bottom: 10,
                          child: Row(
                            children: List.generate(
                              2, // Number of pages
                              (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentPage == index
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'All Medical Devices',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 20,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
