import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/model/nurseCenterModel.dart';
import 'package:test/sections/NurseCenterSection/nurseCenterDetailes.dart';

class NurseCenters extends StatefulWidget {
  final String userEmail;
  const NurseCenters({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<NurseCenters> createState() => _NurseCentersState();
}

class _NurseCentersState extends State<NurseCenters> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1C8892),
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          title: Text(
            "Centers",
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
          ),
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
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: height / 4.5,
              decoration: BoxDecoration(
                color: Color(0xFF1C8892),
              ),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "images/centerSec.svg",
                    width: width,
                    fit: BoxFit.cover,
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
                  padding: EdgeInsets.all(width * 0.02),
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
                            padding: EdgeInsets.all(width * 0.04),
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
                                        centerProfileImage:
                                            center.centerProfileImage,
                                        centerPhoneNumber: center.phoneNumber,
                                        centerAddress1: center.addressOne,
                                        centerEmail: center.emailAddress,
                                        centerWebsite: center.website,
                                        centerLocation: center.centerLocation,
                                        pricePreDay: center.pricePreDay,
                                        pricePreMonth: center.pricePreMonth,
                                        userEmail: widget.userEmail,
                                        centerId: snapshot.data!.docs[index].id,
                                        priceCheckups: center.checkup,
                                        pricePersixMonths:
                                            center.pricePersixMonths,
                                        pricePerthreeMonths:
                                            center.pricePerthreeMonths,
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
                                height: height / 6.5,
                                child: Padding(
                                  padding: EdgeInsets.all(width * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: width / 3,
                                        child: CircleAvatar(
                                          radius: height / 14,
                                          backgroundImage: NetworkImage(
                                            center.centerProfileImage,
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
                                                fontSize: width * 0.045,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: height * 0.01),
                                            Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.calendarDays,
                                                  size: width * 0.03,
                                                ),
                                                SizedBox(width: width * 0.01),
                                                Text(
                                                  center.operatingDays,
                                                  style: TextStyle(
                                                      fontSize: width * 0.035),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: height * 0.01),
                                            Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.clock,
                                                  size: width * 0.03,
                                                ),
                                                SizedBox(width: width * 0.01),
                                                Text(
                                                  center.operatingHours,
                                                  style: TextStyle(
                                                      fontSize: width * 0.035),
                                                ),
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
