import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/nurseCenterModel.dart';
import 'package:test/sections/nurseCenterDetailes.dart';

class NurseCenters extends StatelessWidget {
  const NurseCenters({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Nurse centers",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('centers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<NurseCenter> nurseCenters = snapshot.data!.docs
                .map((doc) =>
                    NurseCenter.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: nurseCenters.length,
              itemBuilder: (context, index) {
                var center = nurseCenters[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedNurseCenter(
                            centerName: center.name,
                            operatingHours: center.operatingHours,
                            centerDescription: center.description,
                            centerUrlImageLogo: center.urlLogoImage,
                            centerPhoneNumber: center.phoneNumber,
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
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 150.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 48,
                                    child: Image.network(
                                      center.urlLogoImage,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      center.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.solidStar,
                                              size: 13,
                                              color: Colors.yellowAccent,
                                            ),
                                            Text("4.5")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.clock,
                                              size: 13,
                                            ),
                                            Text(
                                              center.operatingHours,
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
