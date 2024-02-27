import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/Nursecenters/patientRequestDetails.dart';
import 'package:test/model/patientRequestModel.dart';

class PatientRequest extends StatefulWidget {
  const PatientRequest({Key? key});

  @override
  State<PatientRequest> createState() => _PatientRequestState();
}

class _PatientRequestState extends State<PatientRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Patient request"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("form_request")
                      .where("center_id", isEqualTo: "saMB5oNMINMyfNKifbn")
                      .snapshots(),
                      
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    
                    List<Patient_request> patientRequest = snapshot.data!.docs
                        .map((doc) => Patient_request.fromMap(
                              doc.data() as Map<String, dynamic>,
                            ))
                        .toList();

                    return ListView.builder(
                      
                      itemCount: patientRequest.length,
                      itemBuilder: (context, index) {
                        var patient = patientRequest[index];
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
                                    offset: Offset(0, 3),
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
                                        patient.firstName + patient.lastName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(patient.centerId)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
