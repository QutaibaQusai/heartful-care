import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';
import 'package:test/utils/storeImg%20.dart';

class CenterInformation extends StatefulWidget {
  final String centerEmail;

  const CenterInformation({super.key, required this.centerEmail});

  @override
  State<CenterInformation> createState() => _CenterInformationState();
}

class _CenterInformationState extends State<CenterInformation> {
  bool isEditing = false;
  bool receiveOffers = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController centerNameController = TextEditingController();
  TextEditingController centerContactNumber = TextEditingController();
  TextEditingController centerAddressOne = TextEditingController();
  TextEditingController centerAddressTwo = TextEditingController();
  TextEditingController centerOpiningHours = TextEditingController();
  TextEditingController centerOpiningDays = TextEditingController();
  TextEditingController centerContactName = TextEditingController();
  TextEditingController centerContractPosition = TextEditingController();
  TextEditingController centerDescription = TextEditingController();
  TextEditingController centerWebsite = TextEditingController();
  TextEditingController centerLocation = TextEditingController();
  TextEditingController centerPricePerDay = TextEditingController();
  TextEditingController centerPricePerMonth = TextEditingController();
  TextEditingController centerPricePerMonth6 = TextEditingController();
  TextEditingController centerPricePerMonth3 = TextEditingController();
  TextEditingController centerPriceCheckup = TextEditingController();
  Uint8List? centerImage;
  String? centerImageProfile;
  void selectCenterImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      centerImage = img;
    });
  }

  void saveProfileImageCenter() async {
    StoreImg().saveProfileCenterImg(
        file: centerImage!,
        centerEmail: widget.centerEmail,
        storagePath: "centerProfileImage");
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            content:
                Text('Your ID is: ' + FirebaseAuth.instance.currentUser!.uid),
          ),
        );
      }
    });
  }

  void fetchUserData() async {
    try {
      var centerDoc = await FirebaseFirestore.instance
          .collection('centers')
          .where('Email', isEqualTo: widget.centerEmail)
          .get();

      if (centerDoc.docs.isNotEmpty) {
        var userData = centerDoc.docs[0].data();

        setState(() {
          centerNameController.text = userData['Center Name'] ?? "";
          centerContactNumber.text = userData['Center phone number'] ?? "";
          centerAddressOne.text = userData["Center Address 1"] ?? "";
          centerAddressTwo.text = userData["Center Address 2"] ?? "";
          centerOpiningHours.text = userData["Center operating Hours"] ?? "";
          centerOpiningDays.text = userData["Center operating Days"] ?? "";
          centerContactName.text = userData["Contact Center name"] ?? "";
          centerContractPosition.text =
              userData["Contact Center position"] ?? "";
          centerDescription.text = userData["Center Description"] ?? "";
          centerWebsite.text = userData["Center website"] ?? "";
          centerLocation.text = userData["Center Location"] ?? "";
          centerPricePerDay.text = userData["Price Per Day"] ?? "";
          centerPricePerMonth.text = userData["Price Per one Month"] ?? "";
          centerPricePerMonth6.text = userData["Price Per six Months"] ?? "";
          centerPricePerMonth3.text = userData["Price Per three Months"] ?? "";

          centerPriceCheckup.text = userData["Price_checkup"];
          centerImageProfile = userData["centerProfileImage"] ?? "";
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Center Information"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Color(0xFF1C8892),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(60),
                              child: centerImage != null
                                  ? Image.memory(centerImage!,
                                      fit: BoxFit.cover)
                                  : centerImageProfile != null
                                      ? ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(60),
                                            child: Image.network(
                                                centerImageProfile!,
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                      : ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(60),
                                            child: Image.asset(
                                                "images/logo.png",
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
                              child: isEditing
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          selectCenterImage();
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.camera,
                                          color: Color(0xFF1C8892),
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Basic Information",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter center name',
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty ||
                    //       !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    //     return "Please enter your name correctly ";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerContactNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty ||
                    //       !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                    //           .hasMatch(value) ||
                    //       value.length != 10) {
                    //     return "Please enter your mobile phone number correctly ";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    initialValue: widget.centerEmail.isNotEmpty
                        ? widget.centerEmail
                        : "Guest",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email Address',
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please enter your email address";
                    //   } else if (!RegExp(
                    //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //       .hasMatch(value)) {
                    //     return "Please enter a valid email address";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Location Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerAddressOne,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Address 1',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Address is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerAddressTwo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Address 2 (Optional)',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerLocation,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Center Location Url',
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Operating Hours",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerOpiningHours,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Business Hours',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter operating hours';
                    //   }
                    //
                    //   if (!isValidOperatingHours12HourFormat(value)) {
                    //     return 'Invalid operating hours format. Please enter in hh:mm AM/PM - hh:mm AM/PM format';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerOpiningDays,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Business Days',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter operating hours';
                    //   }
                    //
                    //   if (!isValidOperatingHours12HourFormat(value)) {
                    //     return 'Invalid operating hours format. Please enter in hh:mm AM/PM - hh:mm AM/PM format';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Contact Information",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerContactName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Name is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerContractPosition,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Position',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Position is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerDescription,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Description is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerWebsite,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Website',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Website is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Prices Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    enabled: isEditing,
                    controller: centerPriceCheckup,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Checkup Price',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Description is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerPricePerDay,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price Per Day',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Description is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerPricePerMonth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price Per one Month',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Website is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerPricePerMonth3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price Per three Months',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Website is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerPricePerMonth6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price Per six Months',
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Website is required';
                    //   }
                    //
                    //   return null; // Validation passed
                    // },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: receiveOffers,
                        onChanged: isEditing
                            ? (value) {
                                setState(() {
                                  receiveOffers = value!;
                                });
                              }
                            : null,
                        activeColor: Color(0xFF1C8892),
                      ),
                      Flexible(
                        child: Text(
                          'By registering, the nurse center agrees the apps terms and conditions.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: !isEditing
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Submit your data',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF1C8892)),
                                      ),
                                      content: Text(
                                          'Are you sure you want to submit your data?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            _submitUserData();
                                            saveProfileImageCenter();
                                            Navigator.of(context).pop();
                                            // print(widget.centerEmail);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: Color(0xFF1C8892)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Color(0xFF1C8892)),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: !isEditing
                                  ? Colors.grey
                                  : Colors.black), // Set the outline color
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 18,
                            color: !isEditing ? Colors.grey : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidOperatingHours12HourFormat(String value) {
    RegExp regex = RegExp(
      r'^((1[0-2]|0?[1-9]):[0-5][0-9]\s*(AM|PM)\s*-\s*(1[0-2]|0?[1-9]):[0-5][0-9]\s*(AM|PM))$',
      caseSensitive: false,
    );
    return regex.hasMatch(value);
  }

  Future<void> _submitUserData() async {
    try {
      CollectionReference centers =
          FirebaseFirestore.instance.collection('centers');

      // Find the user document
      var querySnapshot =
          await centers.where("Email", isEqualTo: widget.centerEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];
        var centerId = documentSnapshot.id;

        // Add new fields to the existing document
        await centers.doc(centerId).set({
          'Center Name': centerNameController.text,
          'Center phone number': centerContactNumber.text,
          'Center Address 1': centerAddressOne.text,
          'Center Address 2': centerAddressTwo.text,
          'Center operating Hours': centerOpiningHours.text,
          'Contact Center name': centerContactName.text,
          'Contact Center position': centerContractPosition.text,
          'Center Description': centerDescription.text,
          'Center website': centerWebsite.text,
          'Center Location': centerLocation.text,
          'Center operating Days': centerOpiningDays.text,
          'Price Per Day': centerPricePerDay.text,
          'Price Per one Month': centerPricePerMonth.text,
          'Price Per six Months': centerPricePerMonth6.text,
          'Price Per three Months': centerPricePerMonth3.text,
          'Price_checkup': centerPriceCheckup.text
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'User data updated successfully!',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'User not found',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Error updating user data: $e',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }
}
