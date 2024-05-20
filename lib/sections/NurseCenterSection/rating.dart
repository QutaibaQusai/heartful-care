import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test/model/reveiwsCenterModel.dart';

class CenterRating extends StatefulWidget {
  final String userEmail;
  final String centerId;
  final Function(double) onOverallRatingChanged; // Callback function

  const CenterRating(
      {Key? key,
      required this.userEmail,
      required this.centerId,
      required this.onOverallRatingChanged})
      : super(key: key);

  @override
  State<CenterRating> createState() => _CenterRatingState();
}

class _CenterRatingState extends State<CenterRating> {
  String userName = "";
  double overallRating = 0.0; 

  bool isExpanded = false;
  TextEditingController writeReviewController = TextEditingController();
  RatingController ratingController = RatingController();
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  late List<bool> isExpandedList;

  @override
  void initState() {
    super.initState();
    fetchUserName();
    calculateOverallRating();
    isExpandedList = [];
  }

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
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: Color(0xFF1C8892),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          overallRating
                              .toStringAsFixed(1), // Display overall rating
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        Transform.scale(
                          scale: 0.7,
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reviews_centers')
                      .where('centerId', isEqualTo: widget.centerId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<Reviews_Center> reviewsList = snapshot.data!.docs
                        .map((doc) => Reviews_Center.fromMap(
                            doc.data() as Map<String, dynamic>))
                        .toList();
                    if (isExpandedList.length != reviewsList.length) {
                      isExpandedList = List<bool>.generate(
                          reviewsList.length, (index) => false);
                    }
                    return ListView.builder(
                      itemCount: reviewsList.length,
                      itemBuilder: (context, index) {
                        var review = reviewsList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
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
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.userName,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            review.formattedDate(),
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Transform.scale(
                                        alignment: Alignment.centerRight,
                                        scale: 0.5,
                                        child: RatingBar(
                                          minRating: 1,
                                          maxRating: 5,
                                          initialRating: review
                                              .rating, // Use the 'rating' value
                                          allowHalfRating: true,
                                          ignoreGestures:
                                              true, // Make it read-only
                                          ratingWidget: RatingWidget(
                                            full: Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            half: Icon(Icons.star_half),
                                            empty: Icon(
                                              Icons.star_border,
                                            ),
                                          ),
                                          onRatingUpdate: (double value) {
                                            // This callback won't be triggered since ignoreGestures is set to true
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  AnimatedCrossFade(
                                    firstChild: Text(
                                      review.reviews,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    secondChild: Text(
                                      review.reviews,
                                    ),
                                    crossFadeState: isExpandedList[index]
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: kThemeAnimationDuration,
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpandedList[index] =
                                            !isExpandedList[index];
                                      });
                                    },
                                    child: Text(
                                      isExpandedList[index]
                                          ? "Read Less"
                                          : "Read More",
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
                        );
                      },
                    );
                  },
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
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF1C8892),
              ),
            ),
            onPressed: () {
              writeReview();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Write Review".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void writeReview() {
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
                    color: Color(0xFF1C8892),
                  ),
                ),
                Text(
                  "We're grateful for your input! Your review helps us better understand your needs and improve our service.",
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.6,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar(
                      minRating: 1,
                      maxRating: 5,
                      initialRating: ratingController.rating,
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: Icon(Icons.star_half),
                        empty: Icon(
                          Icons.star_border,
                        ),
                      ),
                      onRatingUpdate: (double value) {
                        ratingController.rating = value;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: writeReviewController,
                    onChanged: (value) {
                      // Update review text as user types
                    },
                    maxLines: null,
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
                          side: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF1C8892),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        if (widget.userEmail.isNotEmpty) {
                          var userDoc = await FirebaseFirestore.instance
                              .collection('users')
                              .where('email', isEqualTo: widget.userEmail)
                              .get();

                          if (userDoc.docs.isNotEmpty) {
                            var userId = userDoc.docs[0].id; // Get the user ID

                            FirebaseFirestore.instance
                                .collection('Reviews_centers')
                                .add({
                              'rating': ratingController.rating,
                              'reviewText': writeReviewController.text,
                              'timestamp': Timestamp.now().toString(),
                              'userName': userName,
                              'userId': userId, // Save the user ID
                              'centerId': widget.centerId,
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF1C8892),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Review submitted successfully!',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            );

                            // Recalculate the overall rating after new review added
                            calculateOverallRating();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF1C8892),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Please log in first',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFF1C8892),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Error saving form data. Please try again later.',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Submit your Review".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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

  void fetchUserName() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        setState(() {
          userName = userDoc.docs[0]['fullname'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void calculateOverallRating() async {
    try {
      var reviewsSnapshot = await FirebaseFirestore.instance
          .collection('Reviews_centers')
          .where('centerId', isEqualTo: widget.centerId)
          .get();

      if (reviewsSnapshot.docs.isNotEmpty) {
        double totalRating = 0.0;
        int numReviews = reviewsSnapshot.docs.length;

        reviewsSnapshot.docs.forEach((doc) {
          totalRating += doc['rating']; // Accumulate ratings
        });
        setState(() {
          overallRating = totalRating / numReviews;
          widget.onOverallRatingChanged(overallRating);
        });

        // Call the callback function with the updated overallRating
      }
    } catch (e) {
      print('Error calculating overall rating: $e');
    }
  }
}

class RatingController {
  double rating = 0.0;
}
