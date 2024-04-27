import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/NurseCenterSection/fillFormRequest.dart';
import 'package:test/sections/NurseCenterSection/rating.dart';
import 'package:test/sections/NurseCenterSection/subcription.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNurseCenter extends StatefulWidget {
  final String centerName;
  final String operatingHours;
  final String operatingDays;
  final String centerPhoneNumber;
  final String centerUrlImageLogo;
  final String centerDescription;
  final String centerAddress1;
  final String centerEmail;
  final String centerWebsite;
  final String centerLocation;
  final String pricePreDay;
  final String pricePreMonth;
  final String pricePersixMonths;
  final String pricePerthreeMonths;

  final String userEmail;
  final String centerId;
  final Function(double) onOverallRatingChanged; // Callback function
  final String priceCheckups;

  DetailedNurseCenter({
    required this.centerName,
    required this.operatingHours,
    required this.centerPhoneNumber,
    required this.centerUrlImageLogo,
    required this.centerDescription,
    required this.centerAddress1,
    required this.centerEmail,
    required this.centerWebsite,
    required this.centerLocation,
    required this.userEmail,
    required this.centerId,
    required this.onOverallRatingChanged,
    required this.operatingDays,
    required this.pricePreDay,
    required this.pricePreMonth,
    required this.priceCheckups,
    required this.pricePersixMonths,
    required this.pricePerthreeMonths,
  });

  @override
  State<DetailedNurseCenter> createState() => _DetailedNurseCenter();
}

class _DetailedNurseCenter extends State<DetailedNurseCenter> {
  double overallRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Centers",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.grey,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(
                                    0xFF1C8892), // You can set the border color here
                                width: 2.0, // You can set the border width here
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.network(
                                widget.centerUrlImageLogo,
                                fit: BoxFit.contain,
                                height: 170,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(width: 16), // Add spacing between image and text
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.centerName,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // SizedBox(height: 8),
                          // Text(
                          //   widget.operatingHours,
                          //   style: TextStyle(fontSize: 16, color: Colors.black),
                          // ),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Icon(
                              //   FontAwesomeIcons.solidStar,
                              //   size: 13,
                              //   color: Color.fromARGB(255, 241, 241, 47),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CenterRating(
                                              userEmail: widget.userEmail,
                                              centerId: widget.centerId,
                                              onOverallRatingChanged:
                                                  (newOverallRating) {
                                                // Update the overallRating in the parent class
                                                setState(() {
                                                  overallRating =
                                                      newOverallRating;
                                                });
                                              },
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      alignment: Alignment.centerLeft,
                                      scale: 0.9,
                                      child: RatingBar.builder(
                                        initialRating: overallRating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // Not needed here, just for demonstration
                                        },
                                      ),
                                    ),
                                    Text(overallRating.toString())
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _makePhoneCall(widget.centerPhoneNumber);
                                    },
                                    icon: Icon(Icons.call,
                                        color: Color(0xFF1C8892)),
                                  ),
                                  Text(
                                    'Call',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(width: 17),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Subscribe(
                                                  pricePreMonth:
                                                      widget.pricePreMonth,
                                                  pricePersixMonths:
                                                      widget.pricePersixMonths,
                                                  pricePerthreeMonths: widget
                                                      .pricePerthreeMonths,
                                                )),
                                      );
                                    },
                                    icon: Icon(Icons.new_releases_outlined,
                                        color: Color(0xFF1C8892)),
                                  ),
                                  Text(
                                    'Subscribe',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(width: 18),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _sendEmail();
                                      // print("ssss :" + widget.centerEmail);
                                    },
                                    icon: Icon(Icons.email,
                                        color: Color(0xFF1C8892)),
                                  ),
                                  Text(
                                    'Email',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Description:".toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.centerDescription),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchWebsite();
                      },
                      child: Text(
                        widget.centerWebsite,
                        style: TextStyle(color: Color(0xFF1C8892)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.red,
                      width: MediaQuery.of(context).size.width / 2,
                      //height: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: Color(0xFF1C8892),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: ListTile(
                                    title: Text("Address",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    subtitle: Text(widget.centerAddress1)),
                              ),
                            ],
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.clock,
                                color: Color(0xFF1C8892),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: ListTile(
                                      title: Text("Operating Hours",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: Text(widget.operatingHours))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.80,
                      // height: MediaQuery.of(context).size.width / 2.5,
                      //color: Colors.green,
                      child: GestureDetector(
                        onTap: () {
                          // Open Google Maps
                          // ignore: deprecated_member_use
                          // launch(
                          //     "https://maps.app.goo.gl/${widget.centerLocation}"
                          //     // "https://maps.app.goo.gl/8jsAsANqBK12moaN8");
                          //     // https://maps.app.goo.gl/qeV4zATskQaats889
                          //     // "https://maps.app.goo.gl/qeV4zATskQaats889");
                          //     );
                        },
                        child: SvgPicture.asset(
                          "images/center_loc.svg",
                          fit: BoxFit.contain,
                          width: 180,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Price details:".toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Price for quickly checkups: " +
                            widget.priceCheckups.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Price per day: " + widget.pricePreDay.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "Price per Month: " + widget.pricePreMonth.toString(),
                    //     style: TextStyle(fontSize: 15),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1C8892),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            onPressed: () {
              if (widget.userEmail.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color(0xFF1C8892),
                    content: Text('Please log in first'),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FormRequest(
                        userEmail: widget.userEmail,
                        centerId: widget.centerId,
                        centerName: widget.centerName,
                        centerAddress1: widget.centerAddress1,
                        checkup: widget.priceCheckups,
                        pricePerDay: widget.pricePreDay,
                      );
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOutQuart;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Fill form".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    String telScheme = 'tel:$phoneNumber';
    try {
      if (await canLaunch(telScheme)) {
        await launch(telScheme);
      } else {
        throw 'Could not launch $telScheme';
      }
    } catch (e) {
      print('Error launching phone call: $e');
      // Handle the error here, such as showing an error dialog
    }
  }

  void _sendEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.centerEmail, // replace with your email address
      queryParameters: {
        'subject': 'Subject Here',
        'body': 'Body Here',
      },
    );

    final String _emailLaunchUriString = _emailLaunchUri.toString();

    try {
      await launch(_emailLaunchUriString);
    } catch (e) {
      print('Error launching email: $e');
      // Handle the error here.
    }
  }

  void _launchWebsite() async {
    final String url = widget.centerWebsite;

    // Check if the URL is not empty and not null
    if (url != true && url.isNotEmpty) {
      // Check if the URL is valid
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // If the URL is not valid, launch Google
        final String googleUrl = 'https://www.google.com';
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not launch $googleUrl';
        }
      }
    } else {
      // If the URL is empty or null, launch Google
      final String googleUrl = 'https://www.google.com';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    }
  }
}
