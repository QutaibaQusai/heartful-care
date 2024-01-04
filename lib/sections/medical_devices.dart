import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Medical extends StatefulWidget {
  @override
  State<Medical> createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  String? selectedLocation;
  TextEditingController searchController = TextEditingController();
  int currentPage = 0;
  PageController pageController = PageController();

  // List of location options
  final List<String> locationOptions = ['Amman, Jordan', 'Irbid', 'Madaba'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                            color: Colors.white, // Set the border color here
                          ),
                          color: Colors.white, // Set the background color here
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.search,
                                color: Colors.black, // Set the icon color here
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: TextField(
                                  controller: searchController,
                                  style: TextStyle(
                                    color:
                                        Colors.black, // Set the text color here
                                  ),
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
                  'Special Offers',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 170,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 2,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return buildSpecialOfferPage(index);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildPageViewDots(),
              SizedBox(height: 10),
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
        ),
      ),
    );
  }

  Widget buildSpecialOfferPage(int index) {
    List<String> titles = ["Special Offer 1", "Special Offer 2"];
    List<String> descriptions = [
      "Get a discount of 20% on selected items!",
      "Buy one, get one free on all medical devices!"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                "images/WhatsApp Image 2024-01-01 at 14.28.49_f2030761.jpg",
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    descriptions[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFF1C8892),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Text(
                        "Today's Offer",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
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

  Widget buildPageViewDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Color(0xFF1C8892) : Colors.grey,
          ),
        ),
      ),
    );
  }
}
