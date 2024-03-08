import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/MedicalDevicesSection/supplierinfo.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplerDetails extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  //final String LogoImage;
  //final String coverImage;
  final String website;
  final String location;
  final String description;
  const SupplerDetails(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.emailAddress,
      required this.website,
      required this.location,
      required this.description});

  @override
  State<SupplerDetails> createState() => _SupplerDetailsState();
}

class _SupplerDetailsState extends State<SupplerDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // toolbarHeight: MediaQuery.of(context).size.height / 5,
          backgroundColor: Color(0xFF1C8892),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.3,
              child: Stack(
                children: [
                  Image.network(
                    "https://lh5.googleusercontent.com/p/AF1QipNWumsi8MRPrfFIsgsN_tXq2O057t54SbkKa8ew=w480-h300-k-n-rw",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 5,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 4.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.red,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUNNBIv06ExHc1ukAR8kBj3xuKlWNOoBMZiAueAxVzj4Dw33zzZPDy1b7EqRUIJSgYrsQ&usqp=CAU",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // color: Colors.amber,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              Text(
                                                "4.8 (5254 Ratings)",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          16,
                                      child: Align(
                                        alignment: AlignmentDirectional.topEnd,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.transparent,
                                            border: Border.all(width: 0),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.info,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SupplierInfo(
                                            supplierName: widget.name,
                                            supplierPhoneNumber:
                                                widget.phoneNumber,
                                            supplierEmailAddress:
                                                widget.emailAddress,
                                            supplierWebsite: widget.website,
                                            supplierLocation: widget.location,
                                            supplierDescription:
                                                widget.description,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _makePhoneCall(widget.phoneNumber);
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
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      left: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                      right: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _launchWebsite();
                                            },
                                            icon: Icon(Icons.link,
                                                color: Color(0xFF1C8892)),
                                          ),
                                          Text(
                                            'Website',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 35,
              color: Colors.red,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Container(
                // color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                      // child: Text("data"),
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            // color: Colors.red,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTvEkQUIq0n3AMgcKON0e2SkFvd1P4PIWoJz3GNN1Qul41UFBY1j7fweQJut4OM38Cu1o&usqp=CAU",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              // color: Colors.amber,
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "pressure device".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),

                                    // textCapitalization: TextCapitalization.words,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "In publishing and graphic design, Lorem ipsum is a placeholder text "),
                                  Expanded(child: Container()),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("200 JD"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text("Rent per day 30"),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
          ],
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
      path: widget.emailAddress, // replace with your email address
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
    final String url = widget.website;

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
