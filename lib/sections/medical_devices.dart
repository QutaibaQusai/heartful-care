import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Medical extends StatefulWidget {
  @override
  State<Medical> createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 8,
              ), // Add some space between "Location" and the next row
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Color(0xFF1C8892),
                    // You can change the color of the location icon
                  ),
                  SizedBox(width: 8),
                  // Add space between the icon and the dropdown
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Select Location'),
                      value: selectedLocation,
                      items: <String>['Amman,Jordan', 'Irbid', 'Madaba']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                      // onChanged is optional; you can remove it if you don't need to handle value changes
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Color(0xFF1C8892)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.search),
                      SizedBox(width: 8),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Search here ',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1C8892)),
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF1C8892),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Looking for your desired\ndevices quickly?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Best In price",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Very Quick delivery",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Get Refund policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "All Medical Devices",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 10,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "images/pressure.png",
                            width: 145,
                            height: 143,
                          ),

                          Positioned(
                            top: 85,
                            left: 15,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily:
                                          GoogleFonts.lexend().fontFamily),
                                ),
                              ),
                            ),
                          )
                          // : Container()
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pressure device",
                            style: TextStyle(
                              color: const Color(0xFF515F65),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.lexend().fontFamily,
                            ),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  FontAwesomeIcons.starHalfStroke,
                                  color: Color(0xFFFFDF41),
                                  size: 13,
                                ),
                              ),
                              Text(
                                "4.0",
                                // item.itemRate.toString(),
                                style: TextStyle(
                                    color: const Color(0xFF23233C),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.lexend().fontFamily,
                                    height: 2.2),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2FBFF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.squareMinus,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    // setState(() {});
                                    // if (item.qty == 0) {
                                    //   return;
                                    // } else {
                                    //   item.qty = item.qty - 1;
                                    //   item.totalPrice = item.qty * item.itemPrice;
                                    // }
                                  },
                                ),
                                Text(
                                  "ads",
                                  // "\$${item.totalPrice}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      fontFamily:
                                          GoogleFonts.lexend().fontFamily),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.squarePlus,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
