import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:test/model/card.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/NurseCenterSection/addCard.dart';
import 'package:test/sections/NurseCenterSection/loadingRequestResult.dart';

class CheckoutNurseCenter extends StatefulWidget {
  final String centerName;
  final String centerAddress1;
  final String userEmail;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String centerId;
  final String patientFirstName;
  final String patientLastName;
  final String patientPhoneNumber;
  final String age;
  final String gender;
  final String address;
  final bool hasAllergies;
  final bool isWalk;
  final bool historyOfSurgeries;
  final List needNurse;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  const CheckoutNurseCenter({
    Key? key,
    required this.centerName,
    required this.centerAddress1,
    required this.userEmail,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.centerId,
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientPhoneNumber,
    required this.age,
    required this.gender,
    required this.address,
    required this.hasAllergies,
    required this.isWalk,
    required this.historyOfSurgeries,
    required this.needNurse,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  State<CheckoutNurseCenter> createState() => _CheckoutNurseCenterState();
}

class _CheckoutNurseCenterState extends State<CheckoutNurseCenter> {
  String userArea = '';
  String userStreet = '';
  String userMobileNumber = '';
  String selectedPaymentMethod = '';
  String? _selectedCard;
  int status = 0;
  DocumentReference newDocRef =
      FirebaseFirestore.instance.collection('form_request').doc();

  @override
  void initState() {
    super.initState();
    if (widget.userEmail.isNotEmpty) {
      context.read<MyProvider>().fetchAndCheckUserSubscription(
          userEmail: widget.userEmail, centerId: widget.centerId);
      context.read<MyProvider>().getUserInfo(userEmail: widget.userEmail);
    }
  }

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
                    height: MediaQuery.of(context).size.height / 3.3,
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
                          child: Image.network(
                            "https://miro.medium.com/v2/resize:fit:1400/1*qYUvh-EtES8dtgKiBRiLsA.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Consumer<MyProvider>(
                          builder: (context, value, child) => Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.userInfo!.area,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        value.userInfo!.street,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Mobile Number: ${value.userInfo!.phoneNumber}",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
              Consumer<MyProvider>(
                builder: (context, value, child) {
                  if (value.userSubscription == null ||
                      value.userSubscription!.subscriptionStatus == 0) {
                    return Container(
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
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AddCard(
                                      userEmail: widget.userEmail,
                                      total: widget.total,
                                      deliveryFee: widget.deliveryFee,
                                    );
                                  }));
                                },
                                child: SizedBox(
                                  height: 80,
                                  child: Container(
                                    decoration: BoxDecoration(
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('email', isEqualTo: widget.userEmail)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return Text('No user data found');
                                  }

                                  var userDoc = snapshot.data!.docs.first;
                                  String userId = userDoc.id;

                                  return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userId)
                                        .collection('Cards')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            cardsSnapshot) {
                                      if (cardsSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      if (cardsSnapshot.hasError) {
                                        return Text(
                                            'Error fetching cards: ${cardsSnapshot.error}');
                                      }
                                      if (!cardsSnapshot.hasData ||
                                          cardsSnapshot.data!.docs.isEmpty) {}
                                      List<UsersCards> cards = cardsSnapshot
                                          .data!.docs
                                          .map((cardDoc) {
                                        return UsersCards.fromMap(cardDoc.data()
                                            as Map<String, dynamic>);
                                      }).toList();

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: cards.length,
                                        itemBuilder: (context, index) {
                                          return Dismissible(
                                            key: UniqueKey(),
                                            direction:
                                                DismissDirection.startToEnd,
                                            onDismissed: (direction) async {
                                              setState(() {
                                                // Remove card from the list view
                                                cards.removeAt(index);
                                              });

                                              // Get the auto-generated document ID of the card
                                              String cardId = cardsSnapshot
                                                  .data!.docs[index].id;

                                              // Delete card from Firestore
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userId)
                                                    .collection('Cards')
                                                    .doc(cardId)
                                                    .delete();
                                              } catch (e) {
                                                print(
                                                    'Error deleting card: $e');
                                                // Re-add the card to the list if deletion fails
                                                setState(() {
                                                  cards.insert(
                                                      index, cards[index]);
                                                });
                                              }
                                            },
                                            background: Container(
                                              color: Color(0xFF1C8892),
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 16.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    style: BorderStyle.solid,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 17),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .ccVisa,
                                                            color: Color(
                                                                0xFF1C8892),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(cards[index]
                                                              .cardNumber),
                                                        ],
                                                      ),
                                                      Radio<String>(
                                                        activeColor:
                                                            Color(0xFF1C8892),
                                                        value: cards[index]
                                                            .cardNumber,
                                                        groupValue:
                                                            _selectedCard,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            _selectedCard =
                                                                value;
                                                            selectedPaymentMethod =
                                                                'card'; // Select payment method as card
                                                          });
                                                        },
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
                                  );
                                },
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPaymentMethod = 'cash';
                                    _selectedCard = null; // Clear selected card
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12),
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
                                        Radio(
                                          activeColor: Color(0xFF1C8892),
                                          value: 'cash',
                                          groupValue: selectedPaymentMethod,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedPaymentMethod = value!;
                                              _selectedCard =
                                                  null; // Clear selected card
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                    ;
                  }
                  return SizedBox();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<MyProvider>(builder: (context, value, child) {
                if (value.userSubscription != null) {
                  return SizedBox();
                }
                return Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment summary",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal"),
                            Text("JOD ${widget.subtotal.toStringAsFixed(2)}"),
                            // Display subtotal
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery fee"),
                            Text(
                                "JOD ${widget.deliveryFee.toStringAsFixed(2)}"),
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
                            Text(
                                "JOD ${widget.total + widget.deliveryFee}", // Calculate total amount
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1C8892),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            onPressed: () {
              _saveFormDataToFirestore();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RequestResult(
                        status: status,
                        formRequestId: newDocRef.id.toString(),
                      )));
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

  void _saveFormDataToFirestore() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || userId.isEmpty) {
      print('User ID is missing');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('You need to be logged in to submit a form.'),
        ),
      );
      return;
    }

    try {
      // Generate a new document ID

      // Initialize the form data map including the new document ID
      Map<String, dynamic> formData = {
        'form_request_id':
            newDocRef.id, // Include the pre-generated ID in the data
        'user_id': userId,
        'center_id': widget.centerId,
        'firstName': widget.patientFirstName,
        'lastName': widget.patientLastName,
        'phoneNumber': widget.patientPhoneNumber,
        'age': widget.age,
        'gender': widget.gender,
        'address': widget.address,
        'hasAllergies': widget.hasAllergies,
        'isWalk': widget.isWalk,
        'historyOfSurgeries': widget.historyOfSurgeries,
        'needNurse': widget.needNurse,
        'date': widget.selectedDate,
        'time': widget.selectedTime.format(context),
        'total_amount': widget.total,
        'payment_method': selectedPaymentMethod,
        'status': status,
      };

      // Add the document with the pre-generated ID
      await newDocRef.set(formData);

      print("Document ID of newly created form_request: ${newDocRef.id}");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Color(0xFF1C8892),
      //     content: Text(
      //         'Form data saved successfully! Document ID: ${newDocRef.id}'),
      //   ),
      // );
    } catch (e) {
      print('Error saving form data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('Error saving form data. Please try again later.'),
        ),
      );
    }
  }
}
