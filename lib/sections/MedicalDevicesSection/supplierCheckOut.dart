import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test/model/card.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/NurseCenterSection/addCard.dart';

class SupplierCheckout extends StatefulWidget {
  final String userEmail;
  final String supplierId;
  const SupplierCheckout({
    super.key,
    required this.userEmail,
    required this.supplierId,
  });

  @override
  State<SupplierCheckout> createState() => _SupplierCheckOitState();
}

class _SupplierCheckOitState extends State<SupplierCheckout> {
  String selectedPaymentMethod = '';
  String? _selectedCard;
  int status = 0;
  @override
  void initState() {
    context.read<MyProvider>().getUserInfo(userEmail: widget.userEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          centerTitle: true,
          title: Consumer<MyProvider>(
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          leading: Container(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<MyProvider>(
            builder: (context, value, child) => Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.userInfo!.area.toUpperCase(),
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
                                        "Mobile Number: " +
                                            value.userInfo!.phoneNumber,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
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
                                  total: 3,
                                  deliveryFee: 5,
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
                                return CircularProgressIndicator(
                                  color: Color(0xFF1C8892),
                                );
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
                                            padding:
                                                EdgeInsets.only(right: 16.0),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                        FontAwesomeIcons.ccVisa,
                                                        color:
                                                            Color(0xFF1C8892),
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
                                          _selectedCard = null;
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<MyProvider>(
          builder: (context, value, child) => Padding(
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
              onPressed: () {},
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
      ),
    );
  }
}
