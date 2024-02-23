import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CenterRating extends StatefulWidget {
  const CenterRating({super.key});

  @override
  State<CenterRating> createState() => _CenterRatingState();
}

class _CenterRatingState extends State<CenterRating> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          title: Text(
            "Reviews",
            style: TextStyle(color: Colors.white),
          ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: Color(0xFF1C8892),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Overall Rating",
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                        Text(
                          "4.8",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        Transform.scale(
                          scale: 0.7, // Adjust the scale factor as needed
                          child: RatingBar(
                            minRating: 1,
                            maxRating: 5,
                            initialRating: 3,
                            allowHalfRating: true,
                            ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: Icon(Icons.star),
                                empty: Icon(
                                  Icons.star,
                                )),
                            onRatingUpdate: (double value) {},
                          ),
                        ),
                        Text(
                          "Based on Reviews",
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                    Lottie.asset('images/Animation - 1708694979012.json',
                        width: 175),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 237, 237, 237),
                          color: Color(0xFFD1E7E9),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      "images/logo2.png",
                                      width: 40, // Adjust width as needed
                                      height: 40, // Adjust height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Qutaiba Qusai Makahleh",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "02 February 2024",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  // Expanded(child: Container()),
                                  // Transform.scale(
                                  //   scale: 0.5, // Adjust the scale factor as needed
                                  //   child: RatingBar(
                                  //     minRating: 1,
                                  //     maxRating: 5,
                                  //     initialRating: 3,
                                  //     allowHalfRating: true,
                                  //     ratingWidget: RatingWidget(
                                  //         full: Icon(
                                  //           Icons.star,
                                  //           color: Colors.amber,
                                  //         ),
                                  //         half: Icon(Icons.star),
                                  //         empty: Icon(
                                  //           Icons.star,
                                  //         )),
                                  //     onRatingUpdate: (double value) {},
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AnimatedCrossFade(
                                firstChild: Text(
                                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                secondChild: Text(
                                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
                                ),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: kThemeAnimationDuration,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded ? "Read Less" : "Read More",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 237, 237, 237),
                          color: Color(0xFFD1E7E9),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      "images/logo2.png",
                                      width: 40, // Adjust width as needed
                                      height: 40, // Adjust height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Qutaiba Qusai Makahleh",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "02 February 2024",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  // Expanded(child: Container()),
                                  // Transform.scale(
                                  //   scale: 0.5, // Adjust the scale factor as needed
                                  //   child: RatingBar(
                                  //     minRating: 1,
                                  //     maxRating: 5,
                                  //     initialRating: 3,
                                  //     allowHalfRating: true,
                                  //     ratingWidget: RatingWidget(
                                  //         full: Icon(
                                  //           Icons.star,
                                  //           color: Colors.amber,
                                  //         ),
                                  //         half: Icon(Icons.star),
                                  //         empty: Icon(
                                  //           Icons.star,
                                  //         )),
                                  //     onRatingUpdate: (double value) {},
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AnimatedCrossFade(
                                firstChild: Text(
                                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                secondChild: Text(
                                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
                                ),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: kThemeAnimationDuration,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded ? "Read Less" : "Read More",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
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
              )
            ],
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
              writeReview();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "write review".toUpperCase(),
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

  writeReview() {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
      ),
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Write your Review",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Color(0xFF1C8892)),
                ),
                Text(
                  "We're grateful for your input! Your review helps us better understand your needs and improve our service.",
                  style: TextStyle(
                      fontSize: 17, height: 1.6, color: Colors.grey[700]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar(
                      minRating: 1,
                      maxRating: 5,
                      initialRating: 3,
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          half: Icon(Icons.star),
                          empty: Icon(
                            Icons.star,
                          )),
                      onRatingUpdate: (double value) {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100, // Adjust height as needed
                  child: TextField(
                    maxLines: null, // Allows multiple lines
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Write your review here...",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C8892),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
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
                      writeReview();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "submit your review".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
