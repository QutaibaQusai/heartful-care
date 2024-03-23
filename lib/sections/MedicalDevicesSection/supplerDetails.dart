import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test/model/devicesModel.dart';
import 'package:test/sections/MedicalDevicesSection/deviceDetails.dart';
import 'package:test/sections/MedicalDevicesSection/ratingSupp.dart';
import 'package:test/sections/MedicalDevicesSection/supplierinfo.dart';

class SupplierDetails extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String logoImage;
  final String website;
  final String location;
  final String description;
  final String paymentOption;
  final String userEmail;
  final String supplierCover;
  final String supplierId;
  final Function(double) onOverallRatingChanged;
  const SupplierDetails({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.website,
    required this.location,
    required this.description,
    required this.paymentOption,
    required this.logoImage,
    required this.userEmail,
    required this.supplierCover,
    required this.supplierId,
    required this.onOverallRatingChanged,
  }) : super(key: key);

  @override
  _SupplierDetailsState createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  double overallRating = 0.0;

  ScrollController _scrollController = ScrollController();

  static const String optionTopDevices = "Top Device";
  static const String optionRent = "Rent device";
  static const String optionBuy = "Buy device";

  void _scrollToSection(String option) {
    double offset = 0.0;
    switch (option) {
      case optionTopDevices:
        offset = 0.0;
        break;
      case optionRent:
        offset = MediaQuery.of(context).size.height / 3.3 + 50.0;
        break;
      case optionBuy:
        offset = MediaQuery.of(context).size.height / 3.3 + 50.0 + 50.0;
        break;
    }
    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3.3,
                child: Stack(
                  children: [
                    InstaImageViewer(
                      child: Image.network(
                        widget.supplierCover,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 5,
                        width: double.infinity,
                      ),
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
                                      child: InstaImageViewer(
                                        backgroundColor: Color(0xFF1C8892),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          child: Image.network(
                                            widget.logoImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Container(
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
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RatingSupplier(
                                                                  userEmail: widget
                                                                      .userEmail,
                                                                  supplierId: widget
                                                                      .supplierId,
                                                                  onOverallRatingChanged:
                                                                      (newOverallRating) {
                                                                    // Update the overallRating in the parent class
                                                                    setState(
                                                                        () {
                                                                      overallRating =
                                                                          newOverallRating;
                                                                    });
                                                                  },
                                                                )));
                                                  },
                                                  child: Text(
                                                    "(Reviews)",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                16,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
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
                                              paymentOption:
                                                  widget.paymentOption,
                                              logoImage: widget.logoImage,
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
                                              style: TextStyle(
                                                  color: Colors.black),
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
                height: 35,
                color: Color(0xFF1C8892),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildOptionButton(optionTopDevices),
                    _buildOptionButton(optionRent),
                    _buildOptionButton(optionBuy),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Suppliers')
                    .snapshots(),
                builder: (context, supplierSnapshot) {
                  if (supplierSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (supplierSnapshot.hasError) {
                    return Text('Error: ${supplierSnapshot.error}');
                  }
                  if (!supplierSnapshot.hasData ||
                      supplierSnapshot.data!.docs.isEmpty) {
                    return Text('No data available');
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Devices')
                        .where("supplierId", isEqualTo: widget.supplierId)
                        .snapshots(),
                    builder: (context, deviceSnapshot) {
                      if (!deviceSnapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<Devices> devices = deviceSnapshot.data!.docs
                          .map((doc) => Devices.fromMap(
                              doc.data() as Map<String, dynamic>))
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          var device = devices[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            child: Image.network(
                                              device.deviceImage1,
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
                                            height: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  device.deviceName
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  device.deviceDescription,
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 3,
                                                ),
                                                Expanded(child: Container()),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            right: BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10.0),
                                                          child: Text(device
                                                              .devicePrice),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                            "Rent per week 30JD"),
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
                                  Divider(),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DeviceDetails(
                                          deviceName: device.deviceName,
                                          deviceDescription:
                                              device.deviceDescription,
                                          priceForBuying: device.devicePrice,
                                          priceForRent: device.deviceRent,
                                          userEmail: widget.userEmail,
                                          deviceImage1: device.deviceImage1,
                                          deviceImage2: device.deviceImage2,
                                          deviceImage3: device.deviceImage3,
                                        )));
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    return InkWell(
      onTap: () {
        _scrollToSection(option);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Text(
          option,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
    }
  }

  void _sendEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.emailAddress,
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
    }
  }

  void _launchWebsite() async {
    final String url = widget.website;

    if (url.isNotEmpty) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        final String googleUrl = 'https://www.google.com';
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not launch $googleUrl';
        }
      }
    } else {
      final String googleUrl = 'https://www.google.com';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    }
  }
}
