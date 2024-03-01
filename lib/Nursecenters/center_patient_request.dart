import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/Nursecenters/patientRequestDetails.dart';
import 'package:test/model/patientRequestModel.dart';

Future<String> getCurrentCenterId() async {
  final center = FirebaseAuth.instance.currentUser;

  if (center != null) {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('centers')
        .doc(center.centerId)
        .get();

    final centerId = docSnapshot.data()?['center_id'];

    return centerId ?? '';
  }

  return '';
}

class PatientRequest extends StatefulWidget {
  const PatientRequest({Key? key}) : super(key: key);

  @override
  State<PatientRequest> createState() => _PatientRequestState();
}

class _PatientRequestState extends State<PatientRequest> {
  late Future<String> centerIdFuture;

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
          centerTitle: true,
          title: const Text("Patient Requests"),
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

                  return Expanded(
                    child: ListView.builder(
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
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: const Offset(0, 3),
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
                                    Expanded(
                                      child: Text(
                                        "${patient.firstName} ${patient.lastName}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(patient.centerId),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
