import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:test/Nursecenters/center_patient_request.dart';

class CentersHome extends StatefulWidget {
  const CentersHome({super.key});

  @override
  State<CentersHome> createState() => _CentersHome();
}

class _CentersHome extends State<CentersHome> {
  bool isEditing = false;
  bool receiveOffers = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController centerNameController = TextEditingController();
  TextEditingController centerContactNumber = TextEditingController();
  TextEditingController centerEmailAddress = TextEditingController();
  TextEditingController centerAddressOne = TextEditingController();
  TextEditingController centerAddressTwo = TextEditingController();
  TextEditingController centerOpiningHours = TextEditingController();
  TextEditingController centerContactName = TextEditingController();
  TextEditingController centerContractPosition = TextEditingController();
  TextEditingController centerDescription = TextEditingController();
  TextEditingController centerWebsite = TextEditingController();
  TextEditingController urlLogoImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PatientRequest();
                  }));
                },
                icon: Icon(FontAwesomeIcons.bell, color: Color(0xFF1C8892)))
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
                  Lottie.asset('images/lottie/Animation - 1706116974821.json',
                      width: 1000),
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
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "Please enter your name correctly ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      enabled: isEditing,
                      controller: centerContactNumber,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone Number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                .hasMatch(value) ||
                            value.length != 10) {
                          return "Please enter your mobile phone number correctly ";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerEmailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email address";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please enter a valid email address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: urlLogoImage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'URL logo Image',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'URL logo Image is required';
                      }

                      return null; // Validation passed
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }

                      return null; // Validation passed
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter operating hours';
                      }

                      if (!isValidOperatingHours12HourFormat(value)) {
                        return 'Invalid operating hours format. Please enter in hh:mm AM/PM - hh:mm AM/PM format';
                      }

                      return null; // Validation passed
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }

                      return null; // Validation passed
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerContractPosition,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Position',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Position is required';
                      }

                      return null; // Validation passed
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }

                      return null; // Validation passed
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: isEditing,
                    controller: centerWebsite,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Website',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Website is required';
                      }

                      return null; // Validation passed
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
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
                                // Confirm deletion
                                CollectionReference centers = FirebaseFirestore
                                    .instance
                                    .collection('centers');
                                centers.add({
                                  'Center Name': centerNameController.text,
                                  'Center phone number':
                                      centerNameController.text,
                                  'Center Email Address':
                                      centerEmailAddress.text,
                                  'Center Address 1': centerAddressOne.text,
                                  'Center Address 2': centerAddressTwo.text,
                                  'Center operating Hours':
                                      centerOpiningHours.text,
                                  'Contact Center name': centerContactName.text,
                                  'Contact Center position':
                                      centerContractPosition.text,
                                  'Contact Description': centerDescription.text,
                                  'Contact website': centerWebsite.text,
                                  'URL Logo Image': urlLogoImage.text,
                                });
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
                                            Navigator.of(context).pop();
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
}
