import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Nurse%20Centers/center_nurse_update_information.dart';
import 'package:test/model/nursers.dart';

class CenterMyNurses extends StatelessWidget {
  final String centerId;

  const CenterMyNurses({Key? key, required this.centerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          elevation: 0,
          title: Text(
            "Nurses List",
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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Nurses")
              .where("centerId", isEqualTo: centerId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<Nurses> nurses = snapshot.data!.docs
                .map(
                    (doc) => Nurses.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: nurses.length,
              itemBuilder: (context, index) {
                final nurse = nurses[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CenterNurseUpdateInformation(
                            nurseFirstName: nurse.nurse_firstName,
                            nurseLastName: nurse.nurse_lastName,
                            nurseAge: nurse.nurse_age,
                            nurseGender: nurse.nurse_gender,
                            nursePhoneNumber: nurse.nurse_phoneNumber,
                            nurseSpecialization: nurse.nurseSpecialization,
                            nurseExpedience: nurse.nurse_yearsExperience,
                            nurseQualification: nurse.nurse_qualifications,
                            nurseId: nurse.nurseId,
                            nurseImage: nurse.nurseImage,
                          ),
                        ),
                      );
                    },
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              // deleteDevice(context, device.deviceId);
                              deleteNurse(context, nurse.nurseId);
                            },
                            backgroundColor: Color(0xFF1C8892),
                            icon: Icons.delete,
                          ),
                        ],
                      ),
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
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        "Rn. ${nurse.nurse_firstName} ${nurse.nurse_lastName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    nurse.nurseSpecialization,
                                    style: TextStyle(color: Colors.grey[500]),
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
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Method to delete a nurse from Firestore
  Future<void> deleteNurse(BuildContext context, String nurseId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Nurses")
          .doc(nurseId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Nurse deleted successfully',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to delete device: $error",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }
}
