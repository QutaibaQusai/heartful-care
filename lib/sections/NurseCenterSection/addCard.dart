import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCard extends StatefulWidget {
  final String userEmail;
  final double total;
  final double deliveryFee;

  const AddCard(
      {super.key,
      required this.userEmail,
      required this.total,
      required this.deliveryFee});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers to update UI on text change
    cardNumberController.addListener(_updateCardInfo);
    expiryDateController.addListener(_updateCardInfo);
    cvvController.addListener(_updateCardInfo);
  }

  // This method is called whenever text in any of the TextEditingControllers changes.
  void _updateCardInfo() {
    setState(() {
      // This will trigger a rebuild with updated values.
      // The actual card widget update logic is already handled by binding the controllers to the widget.
    });
  }

  @override
  void dispose() {
    // Remove listeners when disposing to prevent memory leaks
    cardNumberController.removeListener(_updateCardInfo);
    cvvController.removeListener(_updateCardInfo);
    expiryDateController.removeListener(_updateCardInfo);

    cardNumberController.dispose();
    cvvController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Card details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CreditCardWidget(
              showBackView:
                  false, // Set this to false to show the front of the card

              cardBgColor: Color(0xFF1C8892),
              cardNumber: cardNumberController.text,
              expiryDate: expiryDateController.text,
              cardHolderName: 'John Doe',
              cvvCode: cvvController.text,

              onCreditCardWidgetChange: (brand) {},
            ),
            SizedBox(height: 10),
            TextField(
              cursorColor: Color(0xFF1C8892),
              keyboardType: TextInputType.number,
              controller: cardNumberController,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(FontAwesomeIcons.creditCard, color: Color(0xFF1C8892)),
                labelText: 'Enter your card number',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter your card number',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFF1C8892),
                    controller: expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFF1C8892),
                    controller: cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter CVV',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
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
            submitCardDetails();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "pay now".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "JOD ${widget.total + widget.deliveryFee}".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> submitCardDetails() async {
    try {
      // First, find the user document by email
      var userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: widget.userEmail)
          .get();

      // Check if we found the user
      if (userQuery.docs.isNotEmpty) {
        var userId = userQuery.docs.first
            .id; // Assuming email is unique and only fetches one user

        // Create a new document reference in the 'Cards' sub-collection
        var cardRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId) // Use the found userId here
            .collection('Cards')
            .doc(); // Generates a new document with an auto-generated ID

        // Now, set the card details on this new document
        await cardRef.set({
          'cardNumber': cardNumberController.text,
          'expiryDate': expiryDateController.text,
          'cvv': cvvController.text,
          'createdAt': FieldValue.serverTimestamp(),
          // Tracks when the card was added
        });

        // Confirmation message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Card details added successfully"),
        ));

        // Clear the input fields
        cardNumberController.clear();
        cvvController.clear();
        expiryDateController.clear();

        // Optional: Navigate away if needed
        Navigator.pop(context);
      } else {
        // Handle case where no user is found
        print('No user found with that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to find user by email"),
        ));
      }
    } catch (e) {
      // Error handling
      print('Error submitting card details: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add card details"),
      ));
    }
  }
}
