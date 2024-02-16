import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/NurseCenterSection/FillFormRequest.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNurseCenter extends StatefulWidget {
  final String centerName;
  final String operatingHours;
  final String centerPhoneNumber;
  final String centerUrlImageLogo;
  final String centerDescription;
  final String centerAddress1;
  final String centerEmail;
  final String centerWebsite;
  final String centerLocation;
  DetailedNurseCenter(
      {required this.centerName,
      required this.operatingHours,
      required this.centerPhoneNumber,
      required this.centerUrlImageLogo,
      required this.centerDescription,
      required this.centerAddress1,
      required this.centerEmail,
      required this.centerWebsite,
      required this.centerLocation});

  @override
  State<DetailedNurseCenter> createState() => _DetailedNurseCenter();
}

class _DetailedNurseCenter extends State<DetailedNurseCenter> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                fit: BoxFit.cover,
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
                              Icon(
                                FontAwesomeIcons.solidStar,
                                size: 13,
                                color: Color.fromARGB(255, 241, 241, 47),
                              ),
                              Text(" 4.4 (2666 Ratings)"),
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
                              SizedBox(width: 24),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Handle chat action
                                    },
                                    icon: Icon(Icons.chat,
                                        color: Color(0xFF1C8892)),
                                  ),
                                  Text(
                                    'Chat',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(width: 24),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _sendEmail();
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
                          launch(
                              "https://www.google.com/maps?q=${widget.centerLocation}");
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.transparent))),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF1C8892), // Button background color
              ),
            ),
            onPressed: () {
              // TODO
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FormRequest();
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
