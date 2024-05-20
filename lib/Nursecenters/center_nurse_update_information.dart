import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';
import 'package:test/utils/storeImg%20.dart';

class CenterNurseUpdateInformation extends StatefulWidget {
  final String nurseFirstName;
  final String nurseLastName;
  final String nurseAge;
  final String nurseGender;
  final String nursePhoneNumber;
  final String nurseSpecialization;
  final String nurseExpedience;
  final String nurseQualification;
  final String nurseId;
  final String nurseImage;
  const CenterNurseUpdateInformation({
    super.key,
    required this.nurseFirstName,
    required this.nurseLastName,
    required this.nurseAge,
    required this.nurseGender,
    required this.nursePhoneNumber,
    required this.nurseSpecialization,
    required this.nurseExpedience,
    required this.nurseQualification,
    required this.nurseId,
    required this.nurseImage,
  });

  @override
  State<CenterNurseUpdateInformation> createState() =>
      _CenterNurseUpdateInformationState();
}

class _CenterNurseUpdateInformationState
    extends State<CenterNurseUpdateInformation> {
  // gender drop down menu
  String? selectedGender;
  String? nurseSpecialization;
  Uint8List? nurserImage;
  void selectNurseImage({required ImageSource galleryOrCamera}) async {
    Uint8List img = await pickImage(galleryOrCamera);
    setState(() {
      nurserImage = img;
    });
  }

  // Define TextEditingControllers with initial values
  late TextEditingController nurse_firstName;
  late TextEditingController nurse_lastName;
  late TextEditingController nurse_age;
  late TextEditingController nurse_phoneNumber;
  late TextEditingController nurse_yearsExperience;
  late TextEditingController nurse_yearsQualifications;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with data from the widget fields
    nurse_firstName = TextEditingController(text: widget.nurseFirstName);
    nurse_lastName = TextEditingController(text: widget.nurseLastName);
    nurse_age = TextEditingController(text: widget.nurseAge);
    nurse_phoneNumber = TextEditingController(text: widget.nursePhoneNumber);
    nurse_yearsExperience = TextEditingController(text: widget.nurseExpedience);
    nurse_yearsQualifications =
        TextEditingController(text: widget.nurseQualification);
    selectedGender = widget.nurseGender;
    nurseSpecialization = widget.nurseSpecialization;
  }

  @override
  void dispose() {
    // Dispose the controllers when the screen is disposed
    nurse_firstName.dispose();
    nurse_lastName.dispose();
    nurse_age.dispose();
    nurse_phoneNumber.dispose();
    nurse_yearsExperience.dispose();
    nurse_yearsQualifications.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          title: Text(
            "Update nurse profile",
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
                                  child: nurserImage != null
                                      ? Image.memory(nurserImage!,
                                          fit: BoxFit.cover)
                                      : widget.nurseImage.isNotEmpty
                                          ? ClipOval(
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(60),
                                                child: Image.network(
                                                    widget.nurseImage,
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : ClipOval(
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(60),
                                                child: Image.network(
                                                    "https://img.freepik.com/premium-photo/portrait-two-smiling-medical-workers_53419-5671.jpg",
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
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
                                      onPressed: () {
                                        showImageSelectionBottomSheet();
                                      },
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
                              child: TextFormField(
                                controller: nurse_firstName,
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
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: nurse_lastName,
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
                                  height: 60,
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
                            height: 60,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Color(0xFF1C8892),
                              value: nurseSpecialization,
                              onChanged: (newValue) {
                                setState(
                                  () {
                                    nurseSpecialization = newValue;
                                  },
                                );
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
              // submitNurseData();
              submitUpdatedNurseData();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Update profile",
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

  void showImageSelectionBottomSheet() {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(FontAwesomeIcons.image,
                              color: Colors.black)),
                      SizedBox(width: 10),
                      Text("Choose from library",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    selectNurseImage(galleryOrCamera: ImageSource.gallery);
                  },
                ),
                SizedBox(height: 15),
                GestureDetector(
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(FontAwesomeIcons.camera,
                              color: Colors.black)),
                      SizedBox(width: 10),
                      Text("Take photo",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    selectNurseImage(galleryOrCamera: ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> submitUpdatedNurseData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String nurseId;

    // Check if we are updating an existing nurse or creating a new one
    if (widget.nurseId != null) {
      nurseId = widget.nurseId; // Existing nurse ID passed through widget
    } else {
      // Generate a unique ID for a new nurse document
      nurseId = db.collection('Nurses').doc().id;
    }

    try {
      await db.collection('Nurses').doc(nurseId).update(
        {
          // Use trim() to clean the text inputs
          'first_name': nurse_firstName.text.trim(),
          'last_name': nurse_lastName.text.trim(),
          'age': nurse_age.text.trim(),
          'phone_number': nurse_phoneNumber.text.trim(),
          'years_experience': nurse_yearsExperience.text.trim(),
          'qualifications': nurse_yearsQualifications.text.trim(),
          'gender': selectedGender,
          'nurseSpecialization': nurseSpecialization,
        },
      );

      // Handle image uploading if there's an image to upload
      if (nurserImage != null) {
        await StoreImg().uploadNurseProfile(
            file: nurserImage!,
            nurseId: nurseId,
            storagePath: "nurseProfileImage");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Nurse profile updated successfully!",
            style: TextStyle(
              fontSize: 17,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to update nurse profile: $e",
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
