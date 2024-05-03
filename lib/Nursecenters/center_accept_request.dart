import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Nursecenters/center_nurse_information.dart';
import 'package:test/model/nursers.dart';

class CenterAcceptRequest extends StatefulWidget {
  final String centerId;

  final String formRequestId;

  const CenterAcceptRequest(
      {super.key, required this.centerId, required this.formRequestId});

  @override
  State<CenterAcceptRequest> createState() => _CenterAcceptRequestState();
}

class _CenterAcceptRequestState extends State<CenterAcceptRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          centerTitle: true,
          title: Text(
            "Your nurses".toUpperCase(),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Choose the appropriate nurse:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Nurses")
                      .where("centerId", isEqualTo: widget.centerId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<Nurses> nurses = snapshot.data!.docs
                        .map((doc) =>
                            Nurses.fromMap(doc.data() as Map<String, dynamic>))
                        .toList();

                    return ListView.builder(
                      itemCount: nurses.length,
                      itemBuilder: (context, index) {
                        final nurse = nurses[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CenterNurseInformation(
                                  nurseName: nurse.nurse_firstName,
                                  formRequestId: widget.formRequestId,
                                  nurse_lastName: nurse.nurse_lastName,
                                  nurse_age: nurse.nurse_age,
                                  nurse_gender: nurse.nurse_gender,
                                  nurse_phoneNumber: nurse.nurse_phoneNumber,
                                  nurse_yearsExperience:
                                      nurse.nurse_yearsExperience,
                                  nurse_qualifications:
                                      nurse.nurse_qualifications,
                                  nurseSpecialization:
                                      nurse.nurseSpecialization,
                                  nurseImage: nurse.nurseImage,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 4,
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: nurse.nurseImage.isNotEmpty
                                          ? Image.network(
                                              nurse.nurseImage,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "https://online-learning-college.com/wp-content/uploads/2022/05/How-to-Become-a-Nurse-.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rn. ${nurse.nurse_firstName} ${nurse.nurse_lastName}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          nurse.nurseSpecialization,
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                        ),
                                        Text(
                                          '${nurse.nurse_yearsExperience} years of Experience',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
