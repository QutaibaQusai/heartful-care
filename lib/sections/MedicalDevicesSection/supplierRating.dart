import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';

class SupplierRating extends StatefulWidget {
  final String userEmail;
  final String supplierId;

  const SupplierRating({
    Key? key,
    required this.userEmail,
    required this.supplierId,
  }) : super(key: key);

  @override
  State<SupplierRating> createState() => _SupplierRating();
}

class _SupplierRating extends State<SupplierRating> {
  TextEditingController writeReviewController = TextEditingController();
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MyProvider>()
          .getUserSpplierReview(supplier_id: widget.supplierId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          title: Text(
            "Reviews",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  height: height / 4,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C8892),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer<MyProvider>(
                        builder: (context, value, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Overall Rating",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: width * 0.035),
                            ),
                            Text(
                              value.calculateOverallRating().toStringAsFixed(1),
                              style: TextStyle(
                                  color: Colors.white, fontSize: width * 0.09),
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: RatingBar.builder(
                                initialRating: value.calculateOverallRating(),
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
                            Text(
                              "Based on Reviews",
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: width * 0.035),
                            ),
                          ],
                        ),
                      ),
                      Lottie.asset('images/Animation - 1708694979012.json',
                          width: width * 0.45),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                displayUserReview()
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF1C8892)),
            ),
            onPressed: () {
              writeReview();
            },
            child: Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Text(
                "Write Review".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.045,
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
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: width * 0.04,
            right: width * 0.04,
            top: width * 0.04,
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Write your Review",
                  style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF1C8892),
                  ),
                ),
                Text(
                  "We're grateful for your input! Your review helps us better understand your needs and improve our service.",
                  style: TextStyle(
                    fontSize: width * 0.045,
                    height: 1.6,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar(
                      minRating: 1,
                      maxRating: 5,
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: width * 0.07,
                        ),
                        half: Icon(Icons.star_half, size: width * 0.07),
                        empty: Icon(
                          Icons.star_border,
                          size: width * 0.07,
                        ),
                      ),
                      onRatingUpdate: (double value) {
                        _currentRating = value; // Update the rating variable
                      },
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  height: height * 0.1,
                  child: TextField(
                    controller: writeReviewController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Write your review here...",
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C8892),
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: width * 0.04),
                  ),
                ),
                Center(
                  child: Consumer<MyProvider>(
                    builder: (context, value, child) => ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF1C8892)),
                      ),
                      onPressed: () async {
                        try {
                          if (widget.userEmail.isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('Reviews_suppliers')
                                .add({
                              'reviewText': writeReviewController.text,
                              'timestamp': Timestamp.now().toString(),
                              'userName': value.userInfo!.userName,
                              'userId': value.userInfo!.Id,
                              'userImage': value.userInfo!.userImage,
                              'supplierId': widget.supplierId,
                              'rating': _currentRating, // Add the rating value
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF1C8892),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Review submitted successfully!',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF1C8892),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Please log in first',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                  ),
                                ),
                              ),
                            );
                          }
                          await value.getUserSpplierReview(
                              supplier_id:
                                  widget.supplierId); // Fetch updated reviews

                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF1C8892),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Error saving form data. Please try again later.',
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.02),
                        child: Text(
                          "Submit your Review".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
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

// Tile Review
  Widget displayUserReview() {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Consumer<MyProvider>(
      builder: (context, value, child) {
        if (value.isFetching) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF1C8892),
            ),
          );
        }

        if (value.supplierReview == null || value.supplierReview!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            child: Text(
              "No Review found!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: width * 0.05),
            ),
          );
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: value.supplierReview!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFD1E7E9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          value.supplierReview![index].userImage.isEmpty
                              ? ClipOval(
                                  child: Image.asset(
                                    "images/logo2.png",
                                    width: width * 0.1,
                                    height: width * 0.1,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.network(
                                  value.supplierReview![index].userImage,
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  fit: BoxFit.cover,
                                )),
                          SizedBox(width: width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.supplierReview![index].userName,
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    value.supplierReview![index]
                                        .formattedDate(),
                                    style: TextStyle(fontSize: width * 0.035),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Transform.scale(
                            alignment: Alignment.centerRight,
                            scale: 0.6,
                            child: RatingBar.builder(
                              initialRating:
                                  value.supplierReview![index].rating,
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
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Text(value.supplierReview![index].reviews)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
