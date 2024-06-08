import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/NurseCenterSection/nurse_Center_FillFormRequest.dart';
import 'package:test/sections/NurseCenterSection/rating.dart';
import 'package:test/sections/NurseCenterSection/user_center_subcription.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNurseCenter extends StatefulWidget {
  final String centerName;
  final String operatingHours;
  final String operatingDays;
  final String centerPhoneNumber;
  final String centerProfileImage;
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
  final String priceCheckups;

  DetailedNurseCenter({
    required this.centerName,
    required this.operatingHours,
    required this.centerPhoneNumber,
    required this.centerProfileImage,
    required this.centerDescription,
    required this.centerAddress1,
    required this.centerEmail,
    required this.centerWebsite,
    required this.centerLocation,
    required this.userEmail,
    required this.centerId,
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
  void initState() {
    super.initState();
    fetchAndSetRating();
    if (widget.userEmail.isNotEmpty) {
      context.read<MyProvider>().fetchAndCheckUserSubscription(
          userEmail: widget.userEmail, centerId: widget.centerId);
    }
  }

  void fetchAndSetRating() async {
    try {
      var reviewsSnapshot = await FirebaseFirestore.instance
          .collection('Reviews_centers')
          .where('centerId', isEqualTo: widget.centerId)
          .get();

      if (reviewsSnapshot.docs.isNotEmpty) {
        double totalRating = 0.0;
        int numReviews = reviewsSnapshot.docs.length;

        reviewsSnapshot.docs.forEach((doc) {
          totalRating += doc['rating'];
        });

        double newOverallRating = totalRating / numReviews;
        setState(() {
          overallRating = newOverallRating;
        });
      }
    } catch (e) {
      print('Error fetching and calculating overall rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

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
              size: width * 0.05,
            ),
          ),
          title: Text(
            "Center",
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
          ),
          actions: [
            Consumer<MyProvider>(builder: (context, value, child) {
              if (value.userSubscription == null) {
                return SizedBox();
              }

              return Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: value.userSubscription!.subscriptionStatus == 1
                    ? Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFD1E7E9),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Text("PRO",
                              style: TextStyle(
                                  color: Color(0xFF1C8892),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04)),
                        ))
                    : SizedBox(),
              );
            }),
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: Color(0xFF1C8892),
          color: Colors.white,
          onRefresh: () async {
            if (widget.userEmail.isNotEmpty) {
              context.read<MyProvider>().fetchAndCheckUserSubscription(
                  userEmail: widget.userEmail, centerId: widget.centerId);
            }
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(width * 0.04),
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
                                  color: Color(0xFF1C8892),
                                  width: 2.0,
                                ),
                              ),
                              child: Image.network(
                                widget.centerProfileImage,
                                fit: BoxFit.cover,
                                height: height * 0.2,
                              ),
                            )),
                      ),
                      SizedBox(width: width * 0.04),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.centerName,
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                            setState(() {
                                              overallRating = newOverallRating;
                                            });
                                          },
                                        ),
                                      ),
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
                                          itemSize: width * 0.05,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        overallRating.toStringAsFixed(1),
                                        style:
                                            TextStyle(fontSize: width * 0.04),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _makePhoneCall(
                                              widget.centerPhoneNumber);
                                        },
                                        icon: Icon(Icons.call,
                                            color: Color(0xFF1C8892),
                                            size: width * 0.07),
                                      ),
                                      Text(
                                        'Call',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Flexible(
                                  child: Consumer<MyProvider>(
                                    builder: (context, value, child) {
                                      if (value.userSubscription == null ||
                                          value.userSubscription!
                                                  .subscriptionStatus ==
                                              0) {
                                        return Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserCenterSubscription(
                                                      pricePreMonth:
                                                          widget.pricePreMonth,
                                                      pricePersixMonths: widget
                                                          .pricePersixMonths,
                                                      pricePerthreeMonths: widget
                                                          .pricePerthreeMonths,
                                                      centerId: widget.centerId,
                                                      userEmail:
                                                          widget.userEmail,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Image.asset(
                                                "images/pro (1).png",
                                                width: width * 0.07,
                                              ),
                                            ),
                                            Text(
                                              'PRO',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.04),
                                            ),
                                          ],
                                        );
                                      }
                                      return SizedBox();
                                    },
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Flexible(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _sendEmail();
                                        },
                                        icon: Icon(Icons.email,
                                            color: Color(0xFF1C8892),
                                            size: width * 0.07),
                                      ),
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.04),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Description:".toUpperCase(),
                    style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.centerDescription,
                        style: TextStyle(fontSize: width * 0.03),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchWebsite();
                        },
                        child: Text(
                          widget.centerWebsite,
                          style: TextStyle(
                              color: Color(0xFF1C8892), fontSize: width * 0.04),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width / 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  color: Color(0xFF1C8892),
                                  size: width * 0.05,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Flexible(
                                  child: ListTile(
                                      title: Text("Address",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04)),
                                      subtitle: Text(widget.centerAddress1,
                                          style: TextStyle(
                                              fontSize: width * 0.03))),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.clock,
                                  color: Color(0xFF1C8892),
                                  size: width * 0.05,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Flexible(
                                    child: ListTile(
                                        title: Text("Operating Hours",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.04)),
                                        subtitle: Text(widget.operatingHours,
                                            style: TextStyle(
                                                fontSize: width * 0.03)))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width / 2.80,
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "images/center_loc.svg",
                            fit: BoxFit.contain,
                            width: width * 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Consumer<MyProvider>(builder: (context, value, child) {
                    if (value.userSubscription == null ||
                        value.userSubscription!.subscriptionStatus == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price details:".toUpperCase(),
                            style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Text(
                                  "Price for quickly checkups: " +
                                      widget.priceCheckups.toString(),
                                  style: TextStyle(fontSize: width * 0.03),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Text(
                                  "Price per day: " +
                                      widget.pricePreDay.toString(),
                                  style: TextStyle(fontSize: width * 0.03),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return SizedBox();
                  })
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1C8892),
              padding: EdgeInsets.symmetric(
                vertical: height * 0.005,
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
                      return NurseCenterFillFormRequest(
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
              padding: EdgeInsets.all(width * 0.02),
              child: Text(
                "Fill form".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.035,
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
    }
  }

  void _sendEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.centerEmail,
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
    final String url = widget.centerWebsite;

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
