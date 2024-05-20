import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:test/model/card.dart';
import 'package:test/sections/NurseCenterSection/addCard.dart';
// import 'package:lottie/lottie.dart';

class SubscriptionConfirmationPage extends StatefulWidget {
  final String? planPrice;
  final String? planDuration;
  final String centerId;
  final String userEmail;
  const SubscriptionConfirmationPage(
      {Key? key,
      this.planPrice,
      this.planDuration,
      required this.centerId,
      required this.userEmail})
      : super(key: key);

  @override
  _SubscriptionConfirmationPageState createState() =>
      _SubscriptionConfirmationPageState();
}

class _SubscriptionConfirmationPageState
    extends State<SubscriptionConfirmationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveSubscriptionDates();
  }

  String selectedPaymentMethod = '';
  String? selectedCard;
  String? startDate;
  String? endDate;
  int subscriptionStatus = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF1C8892),
          centerTitle: true,
          title: Text(
            'Subscription Confirmation',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
        body: Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay with",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                            MainAxisAlignment.spaceBetween,
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
                                              Text(cards[index].cardNumber),
                                            ],
                                          ),
                                          Radio<String>(
                                            activeColor: Color(0xFF1C8892),
                                            value: cards[index].cardNumber,
                                            groupValue: selectedCard,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedCard = value;
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
                        selectedCard = null; // Clear selected card
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  selectedCard = null; // Clear selected card
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.planDuration == "1"
                    ? Text(
                        "JOD ${widget.planPrice} / ${widget.planDuration} month",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "JOD ${widget.planPrice} / ${widget.planDuration} months",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      saveSubscriptionData();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Join pro".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveSubscriptionDates() {
    // Current date
    DateTime now = DateTime.now();
    startDate = DateFormat('yyyy-MM-dd').format(now);
    // Calculate end date based on the duration
    DateTime endDateCalc =
        now.add(Duration(days: int.tryParse(widget.planDuration ?? '0')! * 30));
    endDate = DateFormat('yyyy-MM-dd').format(endDateCalc);
  }

  Future<String?> fetchUserIdByEmail() async {
    try {
      var userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        return userQuery.docs.first.id; // Returns the user ID
      }
      return null;
    } catch (e) {
      print('Error fetching user ID: $e');
      return null;
    }
  }

  Future<void> saveSubscriptionData() async {
    String? userId = await fetchUserIdByEmail();
    if (userId == null) {
      print('User not found, unable to save subscription data.');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Subscription').add({
        'userId': userId,
        'startDate': startDate,
        'endDate': endDate,
        'userEmail': widget.userEmail,
        'centerId': widget.centerId,
        'paymentMethod': selectedPaymentMethod,
        "subscriptionStatus": subscriptionStatus,
      });

      print('Subscription data saved successfully with User ID: $userId');
    } catch (e) {
      print('Error saving subscription data: $e');
    }
  }
}
