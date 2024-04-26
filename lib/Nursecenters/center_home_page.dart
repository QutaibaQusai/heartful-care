import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test/Nursecenters/center_settings.dart';
import 'package:test/Nursecenters/center_patient_request_details.dart';
import 'package:test/model/patientRequestModel.dart';

Future<String> getCurrentCenterId() async {
  User? center = FirebaseAuth.instance.currentUser;

  if (center != null) {
    return center.uid;
  }

  return '';
}

class CenterHomePage extends StatefulWidget {
  final String centerEmail;
  const CenterHomePage({super.key, required this.centerEmail});

  @override
  State<CenterHomePage> createState() => _CenterHomePageState();
}

class _CenterHomePageState extends State<CenterHomePage> {
  late Future<String> centerIdFuture;
  String centerName = "";

  @override
  void initState() {
    super.initState();
    centerIdFuture = getCurrentCenterId();
    fetchCenterData();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (FirebaseAuth.instance.currentUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xFF1C8892),
              content:
                  Text('Your ID is: ' + FirebaseAuth.instance.currentUser!.uid),
            ),
          );
        }
      },
    );
  }

  void fetchCenterData() async {
    try {
      var supplierDoc = await FirebaseFirestore.instance
          .collection('centers')
          .where('Email', isEqualTo: widget.centerEmail)
          .get();

      if (supplierDoc.docs.isNotEmpty) {
        var userData = supplierDoc.docs[0].data();

        setState(() {
          // _imageUrl = userData['supplier_profile'];
          centerName = userData['Center Name'];
        });
        print(centerName);
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFD1E7E9),
        appBar: AppBar(
          backgroundColor: Color(0xFFD1E7E9),
          title: Text("Requests"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CenterSettings(
                      centerEmail: widget.centerEmail,
                      centerName: centerName,
                      centerId: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                );
              },
              icon: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child:
                    // _imageUrl != null
                    //     ? CircleAvatar(
                    //         radius: 16,
                    //         backgroundImage: NetworkImage(_imageUrl!),
                    //         backgroundColor: Colors.white,
                    //       )
                    //     :
                    CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png'),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Stack(
                  children: [
                    Text(
                      "Nurse Request \nDashboard",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: SvgPicture.asset(
                        "images/supplierHomePage.svg",
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 7,
                          decoration: BoxDecoration(
                            color: Color(0xFF1C8892),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "New requests received. We've got it from here!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Last requests",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<String>(
                        future: centerIdFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text(
                                    "Error fetching center ID or not found"));
                          } else {
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("form_request")
                                  .where("center_id", isEqualTo: snapshot.data)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
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
                                        child: patient.status == 0
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PatientDetails(
                                                        patientFirstName:
                                                            patient.firstName,
                                                        patientLastName:
                                                            patient.lastName,
                                                        patientAge: patient.age,
                                                        patientGender:
                                                            patient.gender,
                                                        patientPhoneNumber:
                                                            patient.phoneNumber,
                                                        patientAddress:
                                                            patient.address,
                                                        patientAllergies:
                                                            patient.allergies,
                                                        patientSurgeriesHistory:
                                                            patient
                                                                .surgeriesHistory,
                                                        patientIsWalk:
                                                            patient.isWalk,
                                                        patientNeedNurse:
                                                            patient.needNurse,
                                                        centerId:
                                                            patient.centerId,
                                                        total_amount: patient
                                                            .total_amount,
                                                        payment_method: patient
                                                            .payment_method,
                                                        status: patient.status,
                                                        formRequestId: patient
                                                            .formRequestId,
                                                        isTheListRequest: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 1,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6.5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${patient.firstName} ${patient.lastName}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
