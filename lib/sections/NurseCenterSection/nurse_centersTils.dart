import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/model/nurseCenterModel.dart';
import 'package:test/sections/NurseCenterSection/nurseCenterDetailes.dart';

class NurseCenters extends StatefulWidget {
  final String userEmail;
  const NurseCenters({Key? key, required this.userEmail});

  @override
  State<NurseCenters> createState() => _NurseCentersState();
}

class _NurseCentersState extends State<NurseCenters> {
  double overallRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1C8892),
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
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4.5,
              decoration: BoxDecoration(
                color: Color(0xFF1C8892),
              ),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "images/centerSec.svg",
                    width: 400,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('centers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<NurseCenter> nurseCenters = snapshot.data!.docs
                          .map((doc) => NurseCenter.fromMap(
                              doc.data() as Map<String, dynamic>))
                          .toList();

                      return ListView.builder(
                        itemCount: nurseCenters.length,
                        itemBuilder: (context, index) {
                          var center = nurseCenters[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return DetailedNurseCenter(
                                        centerName: center.name,
                                        operatingHours: center.operatingHours,
                                        operatingDays: center.operatingDays,
                                        centerDescription: center.description,
                                        centerUrlImageLogo: center.urlLogoImage,
                                        centerPhoneNumber: center.phoneNumber,
                                        centerAddress1: center.addressOne,
                                        centerEmail: center.emailAddress,
                                        centerWebsite: center.website,
                                        centerLocation: center.centerLocation,
                                        pricePreDay: center.pricePreDay,
                                        pricePreMonth: center.pricePreMonth,
                                        userEmail: widget.userEmail,
                                        centerId: snapshot.data!.docs[index].id,
                                        onOverallRatingChanged:
                                            (double newRating) {
                                          setState(() {
                                            newRating = overallRating;
                                          });
                                        },
                                      );
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOutQuart;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                14,
                                            backgroundImage: NetworkImage(
                                              center.urlLogoImage,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                center.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .calendarDays,
                                                        size: 13,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(" " +
                                                      center.operatingDays),
                                                  /*Text(
                                                      overallRating.toString()),
                                                  Transform.scale(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    scale: 0.9,
                                                    child: RatingBar.builder(
                                                      initialRating:
                                                          overallRating,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      ignoreGestures: true,
                                                      itemCount: 5,
                                                      itemSize: 20,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        // Not needed here, just for demonstration
                                                      },
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.clock,
                                                        size: 13,
                                                      ),
                                                      Text(" " +
                                                          center
                                                              .operatingHours),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
