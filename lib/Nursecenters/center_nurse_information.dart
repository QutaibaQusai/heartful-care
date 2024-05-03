import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CenterNurseInformation extends StatefulWidget {
  final String nurseName;
  final String nurse_lastName;
  final String nurse_age;
  final String nurse_gender;
  final String nurse_phoneNumber;
  final String nurse_yearsExperience;
  final String nurse_qualifications;
  final String nurseSpecialization;
  final String nurseImage;
  final String formRequestId;

  const CenterNurseInformation(
      {super.key,
      required this.nurseName,
      required this.formRequestId,
      required this.nurse_lastName,
      required this.nurse_age,
      required this.nurse_gender,
      required this.nurse_phoneNumber,
      required this.nurse_yearsExperience,
      required this.nurse_qualifications,
      required this.nurseSpecialization,
      required this.nurseImage});

  @override
  State<CenterNurseInformation> createState() => _JustTestState();
}

class _JustTestState extends State<CenterNurseInformation> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateStatus(int newStatus) {
    _firestore
        .collection('form_request')
        .doc(widget.formRequestId)
        .update({
          'status': newStatus,
        })
        .then((_) => print("Status updated"))
        .catchError(
          (error) => print("Failed to update status: $error"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          elevation: 0,
          title: Text(
            "Nurse Information",
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
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Color(0xFF1C8892),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(60),
                              child: widget.nurseImage.isNotEmpty
                                  ? ClipOval(
                                      child: SizedBox.fromSize(
                                      size: Size.fromRadius(60),
                                      child: Image.network(widget.nurseImage,
                                          fit: BoxFit.cover),
                                    ))
                                  : ClipOval(
                                      child: SizedBox.fromSize(
                                      size: Size.fromRadius(60),
                                      child: Image.network(
                                          "https://online-learning-college.com/wp-content/uploads/2022/05/How-to-Become-a-Nurse-.jpg",
                                          fit: BoxFit.cover),
                                    )),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                              height: 50,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: widget.nurseName,
                                keyboardType: TextInputType.name,
                                cursorColor: Color(0xFF1C8892),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF1C8892), width: 2.0),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Nurse first name",
                                  labelStyle:
                                      TextStyle(color: Color(0xFF1C8892)),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                style: TextStyle(
                                    color: Colors
                                        .grey[600]), // Change text color here
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 50,
                              child: TextFormField(
                                initialValue: widget.nurse_lastName,
                                cursorColor: Color(0xFF1C8892),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF1C8892), width: 2.0),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Nurse last name",
                                  labelStyle:
                                      TextStyle(color: Color(0xFF1C8892)),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                style: TextStyle(color: Colors.grey[600]),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: TextFormField(
                                    cursorColor: Color(0xFF1C8892),
                                    keyboardType: TextInputType.number,
                                    initialValue: widget.nurse_age,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF1C8892),
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: "age",
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1C8892)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Color(0xFF1C8892),
                                    value: widget.nurse_gender,
                                    onChanged: null,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF1C8892),
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(20),
                                      ), // Change focus color
                                      labelText: "Gender",
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1C8892)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    items: <String>['Male', 'Female']
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    16, // Adjust the font size here
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorColor: Color(0xFF1C8892),
                              keyboardType: TextInputType.phone,
                              initialValue: widget.nurse_phoneNumber,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1C8892), width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Nurse phone number",
                                labelStyle: TextStyle(color: Color(0xFF1C8892)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 60,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Color(0xFF1C8892),
                              value: widget.nurseSpecialization,
                              onChanged: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1C8892), width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ), // Change focus color
                                labelText: "Specialization",
                                labelStyle: TextStyle(color: Color(0xFF1C8892)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              items: <String>[
                                'Pediatric Nursing',
                                'Critical Care Nursing',
                                'Emergency Nursing',
                                'Mental Health Nursing',
                                'Geriatric Nursing',
                                'Oncology Nursing',
                                'Perioperative Nursing',
                                'Community Health Nursing',
                                'Nurse Educator',
                                'Nurse Practitioner'
                              ]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorColor: Color(0xFF1C8892),
                              keyboardType: TextInputType.number,
                              initialValue: widget.nurse_yearsExperience,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1C8892), width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Nurse years experience",
                                labelStyle: TextStyle(color: Color(0xFF1C8892)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorColor: Color(0xFF1C8892),
                              keyboardType: TextInputType.text,
                              initialValue: widget.nurse_qualifications,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1C8892), width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Nurse Qualification",
                                labelStyle: TextStyle(color: Color(0xFF1C8892)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF1C8892), // Button background color
                ),
              ),
              onPressed: () {
                submitNurseData();
                updateStatus(1);

                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop();
              },
              child: Text(
                "accept ".toUpperCase() + widget.nurseName.toUpperCase(),
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


  

  Future<void> submitNurseData() async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;

      await db.collection('form_request').doc(widget.formRequestId).update({
        "nurse_FirstName": widget.nurseName,
        "nurse_LastName": widget.nurse_lastName,
        "nurse_age": widget.nurse_age,
        "nurse_Gender": widget.nurse_gender,
        "nurse_phoneNumber": widget.nurse_phoneNumber,
        "nurse_specialization": widget.nurseSpecialization,
        "nurse_yearsExperience": widget.nurse_yearsExperience,
        "nurse_Qualification": widget.nurse_qualifications
      });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Color(0xFF1C8892),
      //     behavior: SnackBarBehavior.floating,
      //     content: Text(
      //       "Nurse profile created successfully!",
      //       style: TextStyle(
      //         fontSize: 17,
      //         fontFamily: GoogleFonts.poppins().fontFamily,
      //       ),
      //     ),
      //   ),
      // );
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.red,
      //     behavior: SnackBarBehavior.floating,
      //     content: Text(
      //       "Failed to create nurse profile: $e",
      //       style: TextStyle(
      //         fontSize: 17,
      //         fontFamily: GoogleFonts.poppins().fontFamily,
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}
