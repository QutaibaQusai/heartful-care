import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Nurse%20Centers/center_accept_request.dart';

class PatientDetails extends StatefulWidget {
  final String patientFirstName;
  final String patientLastName;
  final String patientAge;
  final String patientGender;
  final String patientPhoneNumber;
  final String patientAddress;
  final bool patientAllergies;
  final bool patientSurgeriesHistory;
  final bool patientIsWalk;
  final List patientNeedNurse;
  final String centerId;
  final double total_amount;
  final String payment_method;
  final int status;
  final String formRequestId;
  final bool isTheListRequest;

  const PatientDetails({
    super.key,
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientAge,
    required this.patientGender,
    required this.patientPhoneNumber,
    required this.patientAddress,
    required this.patientAllergies,
    required this.patientSurgeriesHistory,
    required this.patientIsWalk,
    required this.patientNeedNurse,
    required this.centerId,
    required this.total_amount,
    required this.payment_method,
    required this.status,
    required,
    required this.formRequestId,
    required this.isTheListRequest,
  });

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateStatus(int newStatus) {
    _firestore
        .collection('form_request')
        .doc(widget.formRequestId)
        .update({
          'status': newStatus,
        })
        .then((_) => print("Status updated"))
        .catchError((error) => print("Failed to update status: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          centerTitle: true,
          title: Text(
            "patient info".toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Patient Information:".toUpperCase(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                initialValue: widget.patientFirstName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF1C8892), width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(15, 15)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF1C8892), width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: "First Name ",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                initialValue: widget.patientLastName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF1C8892), width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF1C8892), width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(15, 15)),
                                    ),
                                    labelText: "Last Name ",
                                    labelStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientPhoneNumber,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Phone Number ",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientAge.toString(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Age ",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientGender,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Gender ",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "address ",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Medical Information:".toUpperCase(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientAllergies ? "yes" : "no",
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Do you have any allergies?",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientIsWalk ? "yes" : "no",
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText:
                                  "Is the patient able to walk, or do they use a wheelchair?",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue:
                              widget.patientSurgeriesHistory ? "yes" : "No",
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Do you have a history of surgeries?",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.patientNeedNurse.join('\n'),
                          maxLines: null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Why do you need a nurse?",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.total_amount.toString(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Total price",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.payment_method,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF1C8892), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Payment method",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.isTheListRequest == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.transparent))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF1C8892), // Button background color
                          ),
                        ),
                        onPressed: () {
                          updateStatus(2);
                          Navigator.of(context).pop();
                        },
                        child: Text("reject".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.transparent))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF1C8892),
                          ),
                        ),
                        onPressed: () {
                          // updateStatus(1);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CenterAcceptRequest(
                                centerId: widget.centerId,
                                formRequestId: widget.formRequestId,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "accept".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Row(),
      ),
    );
  }
}
