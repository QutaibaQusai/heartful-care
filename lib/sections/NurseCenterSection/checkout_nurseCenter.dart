import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/model/card.dart';
import 'package:test/sections/NurseCenterSection/addCard.dart';

class CheckoutNurseCenter extends StatefulWidget {
  final String centerName;
  final String centerAddress1;
  final String userEmail;
  final double subtotal;
  final double deliveryFee; // Add delivery fee parameter
// Added subtotal parameter

  const CheckoutNurseCenter({
    Key? key,
    required this.centerName,
    required this.centerAddress1,
    required this.userEmail,
    required this.subtotal,
    required this.deliveryFee, // Added subtotal parameter
  }) : super(key: key);

  @override
  State<CheckoutNurseCenter> createState() => _CheckoutNurseCenterState();
}

class _CheckoutNurseCenterState extends State<CheckoutNurseCenter> {
  String userArea = '';
  String userStreet = '';
  String userMobileNumber = '';
  String _selectedPaymentMethod = '';
  String? _selectedCard;

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
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return AddCard(
                                userEmail: widget.userEmail,
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
                                  AsyncSnapshot<QuerySnapshot> cardsSnapshot) {
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
                                List<UsersCards> cards =
                                    cardsSnapshot.data!.docs.map((cardDoc) {
                                  return UsersCards.fromMap(
                                      cardDoc.data() as Map<String, dynamic>);
                                }).toList();

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cards.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.startToEnd,
                                      onDismissed: (direction) async {
                                        setState(() {
                                          // Remove card from the list view
                                          cards.removeAt(index);
                                        });

                                        // Get the auto-generated document ID of the card
                                        String cardId =
                                            cardsSnapshot.data!.docs[index].id;

                                        // Delete card from Firestore
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userId)
                                              .collection('Cards')
                                              .doc(cardId)
                                              .delete();
                                        } catch (e) {
                                          print('Error deleting card: $e');
                                          // Re-add the card to the list if deletion fails
                                          setState(() {
                                            cards.insert(index, cards[index]);
                                          });
                                        }
                                      },
                                      background: Container(
                                        color: Color(0xFF1C8892),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0, vertical: 17),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.ccVisa,
                                                      color: Color(0xFF1C8892),
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
                                                  value:
                                                      cards[index].cardNumber,
                                                  groupValue: _selectedCard,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _selectedCard = value;
                                                      _selectedPaymentMethod =
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
                              _selectedPaymentMethod = 'cash';
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
                                    groupValue: _selectedPaymentMethod,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPaymentMethod = value!;
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
                          Text(
                              "Subtotal: ${widget.subtotal.toStringAsFixed(2)}"), // Display subtotal
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery fee"),
                          Text("JOD ${widget.deliveryFee.toStringAsFixed(2)}"),
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
                              "JOD ${widget.subtotal + 0.25}", // Calculate total amount
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
                Color(0xFF1C8892),
              ),
            ),
            onPressed: () {
              if (_selectedPaymentMethod == "card") {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return AddCard(
                //     userEmail: widget.userEmail,
                //   );
                // }));
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
    super.initState();
    fetchUserName();
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
