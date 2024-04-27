import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterAddNurse extends StatefulWidget {
  final String centerId;
  final bool isPageAddNurse;
  final String nurse_firstName;
  final String nurse_lastName;

  const CenterAddNurse({
    super.key,
    required this.centerId,
    required this.isPageAddNurse,
    required this.nurse_firstName,
    required this.nurse_lastName,
  });

  @override
  State<CenterAddNurse> createState() => _CenterAddNurseState();
}

class _CenterAddNurseState extends State<CenterAddNurse> {
  // gender drop down menu
  String? selectedGender;
  String? nurseSpecialization;
  // Nurse Controllers
  TextEditingController nurse_firstName = TextEditingController();
  TextEditingController nurse_lastName = TextEditingController();
  TextEditingController nurse_age = TextEditingController();
  TextEditingController nurse_phoneNumber = TextEditingController();
  TextEditingController nurse_yearsExperience = TextEditingController();
  TextEditingController nurse_yearsQualifications = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          elevation: 0,
          title: Text(
            widget.isPageAddNurse
                ? "Create nurse profile"
                : "Edit nurse profile",
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
                          Stack(
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(60),
                                  child: Image.network(
                                      'https://online-learning-college.com/wp-content/uploads/2022/05/How-to-Become-a-Nurse-.jpg',
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        FontAwesomeIcons.camera,
                                        color: Color(0xFF1C8892),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 50,
                            child: widget.isPageAddNurse
                                ? TextFormField(
                                    // initialValue: widget.nurse_firstName,
                                    controller: nurse_firstName,
                                    keyboardType: TextInputType.name,
                                    cursorColor: Color(0xFF1C8892),
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
                                      labelText: "Nurse first name",
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1C8892)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  )
                                : TextFormField(
                                    initialValue: widget.nurse_firstName,
                                    // controller: nurse_firstName,
                                    keyboardType: TextInputType.name,
                                    cursorColor: Color(0xFF1C8892),
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
                                      labelText: "Nurse first name",
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1C8892)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: widget.isPageAddNurse
                                ? TextFormField(
                                    controller: nurse_lastName,
                                    cursorColor: Color(0xFF1C8892),
                                    keyboardType: TextInputType.name,
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
                                      // hintText: 'First Name',
                                      labelText: "Nurse last name",
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1C8892)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  )
                                : TextFormField(
                                    initialValue: widget.nurse_lastName,
                                    cursorColor: Color(0xFF1C8892),
                                    keyboardType: TextInputType.name,
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
                                      // hintText: 'First Name',
                                      labelText: "Nurse last name",
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1C8892)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    cursorColor: Color(0xFF1C8892),
                                    keyboardType: TextInputType.number,
                                    controller: nurse_age,
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
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Color(0xFF1C8892),
                                    value: selectedGender,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedGender = newValue;
                                      });
                                    },
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
                                                color: Colors.black,
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
                              controller: nurse_phoneNumber,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1C8892), width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // hintText: 'First Name',
                                labelText: "Nurse phone number",
                                labelStyle: TextStyle(color: Color(0xFF1C8892)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Color(0xFF1C8892),
                              value: nurseSpecialization,
                              onChanged: (newValue) {
                                setState(() {
                                  nurseSpecialization = newValue;
                                });
                              },
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
                                          color: Colors.black,
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
                              controller: nurse_yearsExperience,
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
                              controller: nurse_yearsQualifications,
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
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              submitNurseData();
              Navigator.of(context).pop;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.isPageAddNurse ? "Create profile" : "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF1C8892),
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
      // Create a document in the 'Nurses' collection
      await db.collection('Nurses').add({
        'first_name': nurse_firstName.text.trim(),
        'last_name': nurse_lastName.text.trim(),
        'age': nurse_age.text.trim(),
        'phone_number': nurse_phoneNumber.text.trim(),
        'years_experience': nurse_yearsExperience.text.trim(),
        'qualifications': nurse_yearsQualifications.text.trim(),
        'gender': selectedGender,
        'centerId': widget.centerId,
        'nurseSpecialization': nurseSpecialization,
      });
      // Show a success message or perform actions after the data is successfully saved

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Nurse profile created successfully!",
            style: TextStyle(
              fontSize: 17,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      );
      // Optionally, clear the form or navigate away
      clearForm();
    } catch (e) {
      // Handle errors, for instance, show an error message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to create nurse profile: $e",
            style: TextStyle(
              fontSize: 17,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      );
    }
  }

  void clearForm() {
    nurse_firstName.clear();
    nurse_lastName.clear();
    nurse_age.clear();
    nurse_phoneNumber.clear();
    nurse_yearsExperience.clear();
    nurse_yearsQualifications.clear();
    selectedGender = null;
  }

  Future<void> updateNurseData() async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      // Create a document in the 'Nurses' collection
      await db.collection('Nurses').add({
        'first_name': nurse_firstName.text.trim(),
        'last_name': nurse_lastName.text.trim(),
        'age': nurse_age.text.trim(),
        'phone_number': nurse_phoneNumber.text.trim(),
        'years_experience': nurse_yearsExperience.text.trim(),
        'qualifications': nurse_yearsQualifications.text.trim(),
        'gender': selectedGender,
        'centerId': widget.centerId,
        'nurseSpecialization': nurseSpecialization,
      });
      // Show a success message or perform actions after the data is successfully saved

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Nurse profile created successfully!",
            style: TextStyle(
              fontSize: 17,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      );
      // Optionally, clear the form or navigate away
      clearForm();
    } catch (e) {
      // Handle errors, for instance, show an error message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to create nurse profile: $e",
            style: TextStyle(
              fontSize: 17,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      );
    }
  }
}
