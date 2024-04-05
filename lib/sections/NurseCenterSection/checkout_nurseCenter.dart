import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/NurseCenterSection/addCard.dart';

class CheckoutNurseCenter extends StatefulWidget {
  final String centerName;
  final String centerAddress1;
  final String userEmail;

  const CheckoutNurseCenter(
      {super.key,
      required this.centerName,
      required this.centerAddress1,
      required this.userEmail});

  @override
  State<CheckoutNurseCenter> createState() => _CheckoutNurseCenterState();
}

class _CheckoutNurseCenterState extends State<CheckoutNurseCenter> {
  String userArea = '';
  String userStreet = '';
  String userMobileNumber = '';
  String _selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Checkout",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                widget.centerName + ", " + widget.centerAddress1,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          leading: Container(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  color: Color(0xFF1C8892),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userArea.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      userStreet,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Mobile Number: " + userMobileNumber,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pay with",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text("ss")
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPaymentMethod = 'card';
                            });
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return AddCard(
                                userEmail: widget.userEmail,
                              );
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.plus,
                                        color: Color(0xFF1C8892),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("Add a new card"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio<String>(
                                        activeColor: Color(0xFF1C8892),
                                        value: 'card',
                                        groupValue: _selectedPaymentMethod,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedPaymentMethod = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPaymentMethod = 'cash';
                            });
                            // print("cash");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.moneyBill,
                                        color: Color(0xFF1C8892),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("Cash"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: Color(0xFF1C8892),
                                        value: 'cash',
                                        groupValue: _selectedPaymentMethod,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedPaymentMethod = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pay with",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Payment summary"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal"),
                          Text("JOD " + "4.00"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery free"),
                          Text("JOD " + "0.25"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total amount",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text("JOD " + "4.25",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      )
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
              if (_selectedPaymentMethod == "card") {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddCard(
                    userEmail: widget.userEmail,
                  );
                }));
              } else {}
              print(_selectedPaymentMethod);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Place order".toUpperCase(),
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

  @override
  void initState() {
    // TODO: implement initState
    fetchUserName();
    super.initState();
  }

  void fetchUserName() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        setState(() {
          userArea = userDoc.docs[0]['Area'];
          userStreet = userDoc.docs[0]['Street'];
          userMobileNumber = userDoc.docs[0]['Phone Number'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  
}
