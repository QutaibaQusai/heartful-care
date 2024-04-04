import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class PaymentOptionPage extends StatefulWidget {
  final String centerId;
  final String firstName;
  final String lastName;
  // final String phoneNumber;
  // final String age;
  // final String? gender;
  // final String address;
  // final bool? hasAllergies;
  // final bool? isWalk;
  // final bool? historyOfSurgeries;
  // final List<String> needNurse;
  // final DateTime? selectedDate;
  // final TimeOfDay? selectedTime;

  const PaymentOptionPage(
      {super.key,
      required this.firstName,
      required this.lastName,
      // required this.phoneNumber,
      // required this.age,
      // this.gender,
      // required this.address,
      // this.hasAllergies,
      // this.isWalk,
      // this.historyOfSurgeries,
      // required this.needNurse,
      // this.selectedDate,
      // this.selectedTime,
      required this.centerId});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  String selectedPaymentOption = '';
  int selectedPaymentPerDay = 1;
  String paymentMethod = 'Visa Card';
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 10),
                Text(
                  "Payment option: ".toUpperCase(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Per Hour',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value as String;
                            });
                          },
                          activeColor: Color(0xFF1C8892),
                        ),
                        Text(
                          'quickly checkups',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Radio(
                          value: 'Per Day',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value as String;
                            });
                          },
                          activeColor: Color(0xFF1C8892),
                        ),
                        Text(
                          'Per Day',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        DropdownButton<int>(
                          value: selectedPaymentPerDay,
                          onChanged: (int? value) {
                            setState(() {
                              selectedPaymentPerDay = value!;
                            });
                          },
                          items: List.generate(30, (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text((index + 1).toString()),
                            );
                          }),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Payment method: ".toUpperCase(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'Visa Card',
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = value.toString();
                                });
                              },
                              activeColor: Color(0xFF1C8892),
                            ),
                            Text(
                              'Visa Card',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CreditCardWidget(
                  cardBgColor: Color(0xFF1C8892),
                  cardNumber: cardNumberController.text,
                  expiryDate: expiryDateController.text,
                  cardHolderName: 'John Doe',
                  cvvCode: cvvController.text,
                  showBackView: true,
                  onCreditCardWidgetChange: (brand) {},
                ),
                if (paymentMethod == 'Visa Card') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        TextField(
                          cursorColor: Color(0xFF1C8892),
                          keyboardType: TextInputType.number,
                          controller: cardNumberController,
                          decoration: InputDecoration(
                            labelText: 'Card Number',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'Enter your card number',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
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
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                Row(
                  children: [
                    Radio(
                      value: 'Cash on delivery',
                      groupValue: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value.toString();
                        });
                      },
                      activeColor: Color(0xFF1C8892),
                    ),
                    Text('Cash on delivery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ],
            ),
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
              _saveFormDataToFirestore();
              // _saveFormDataToFirestore();
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (BuildContext context) {
              //     return PaymentOptionPage(); // Make sure to call the constructor if it's a class.
              //   }),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Continue to confirm".toUpperCase(),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('You need to be logged in to submit a form.'),
        ),
      );
      return;
    }

    try {
      Map<String, dynamic> formData = {
        'user_id': userId,
        'center_id': widget.centerId,
        'firstName': widget.firstName,
        'lastName': widget.lastName,
        // 'phoneNumber': widget.phoneNumber,
        // 'age': widget.age,
        // 'gender': widget.gender,
        // 'address': widget.address,
        // 'hasAllergies': widget.hasAllergies,
        // 'isWalk': widget.isWalk,
        // 'historyOfSurgeries': widget.historyOfSurgeries,
        // 'needNurse': widget.needNurse,
        // 'selectedDate': widget.selectedDate != null
        //     ? Timestamp.fromDate(widget.selectedDate!)
        //     : null,
        // 'selectedTime': widget.selectedTime != null
        //     ? widget.selectedTime!.format(context)
        //     : null,
        'selectedPaymentOption': selectedPaymentOption,
        'selectedPaymentPerDay': selectedPaymentPerDay,
        'paymentMethod': paymentMethod,
        // Ensure other necessary fields are included here.
      };

      await FirebaseFirestore.instance.collection('form_request').add(formData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('Form data saved successfully!'),
        ),
      );
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
