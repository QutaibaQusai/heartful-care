import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Nurse%20Centers/center_patient_request_details.dart';
import 'package:test/model/patientRequestModel.dart';

class CenterRequestsHistory extends StatefulWidget {
  const CenterRequestsHistory({super.key});

  @override
  State<CenterRequestsHistory> createState() => _CenterRequestsHistoryState();
}

class _CenterRequestsHistoryState extends State<CenterRequestsHistory> {
  late Future<String> centerIdFuture;
  String centerName = "";
  Future<String> getCurrentCenterId() async {
    User? center = FirebaseAuth.instance.currentUser;
    if (center != null) {
      return center.uid;
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    centerIdFuture = getCurrentCenterId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          elevation: 0,
          title: Text(
            "History",
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
        body: FutureBuilder<String>(
          future: centerIdFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text("Error fetching center ID or not found"));
            } else {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("form_request")
                    .where("center_id", isEqualTo: snapshot.data)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<Patient_request> patientRequests =
                      snapshot.data!.docs.map((doc) {
                    return Patient_request.fromMap(
                        doc.data() as Map<String, dynamic>);
                  }).toList();

                  return ListView.builder(
                    itemCount: patientRequests.length,
                    itemBuilder: (context, index) {
                      final patient = patientRequests[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDetails(
                                  patientFirstName: patient.firstName,
                                  patientLastName: patient.lastName,
                                  patientAge: patient.age,
                                  patientGender: patient.gender,
                                  patientPhoneNumber: patient.phoneNumber,
                                  patientAddress: patient.address,
                                  patientAllergies: patient.allergies,
                                  patientSurgeriesHistory:
                                      patient.surgeriesHistory,
                                  patientIsWalk: patient.isWalk,
                                  patientNeedNurse: patient.needNurse,
                                  centerId: patient.centerId,
                                  total_amount: patient.total_amount,
                                  payment_method: patient.payment_method,
                                  status: patient.status,
                                  formRequestId: patient.formRequestId,
                                  isTheListRequest: false,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 6.5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${patient.firstName} ${patient.lastName}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Expanded(child: Container()),
                                      Text(
                                        patient.status == 1
                                            ? "Accepted"
                                            : "Rejected",
                                        style: TextStyle(
                                            color: patient.status == 1
                                                ? Color(0xFF1C8892)
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )
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
            }
          },
        ),
      ),
    );
  }
}
