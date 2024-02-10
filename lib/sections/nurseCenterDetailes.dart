import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  DetailedNurseCenter(
      {required this.centerName,
      required this.operatingHours,
      required this.centerPhoneNumber,
      required this.centerUrlImageLogo,
      required this.centerDescription,
      required this.centerAddress1,
      required this.centerEmail,
      required this.centerWebsite});

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
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
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
                              onTap: () {
                                _openGoogleMaps();
                                print("object");
                              },
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.width / 2.5,
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
                                            fontWeight: FontWeight.bold)),
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
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(widget.operatingHours))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.width / 2.5,
                      // color: Colors.green,
                      child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR06MADR69xqUQgvURQxGz868kOIb_-AEWWXgnr3L5h8jf4voSzjAky2oftOhY2D69_cHA&usqp=CAU"),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 40,
                // ),
                // Row(
                //   children: [
                //     Text(
                //       "Website link: " + widget.centerWebsite.toUpperCase(),
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black),
                //     ),

                //   ],
                // ),
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
            onPressed: () {},
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

  void _openGoogleMaps() async {
    final Uri _mapsLaunchUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {
        'api': '1',
        'query': 'YOUR_LOCATION_QUERY_HERE', // replace with your location query
      },
    );

    final String _mapsLaunchUriString = _mapsLaunchUri.toString();

    try {
      await launch(_mapsLaunchUriString);
    } catch (e) {
      print('Error launching Google Maps: $e');
      // Handle the error here.
    }
  }

  void _launchWebsite() async {
    final String url = widget.centerWebsite; // Replace with your website URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
