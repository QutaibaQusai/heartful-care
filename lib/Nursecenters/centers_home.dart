import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:test/Nursecenters/center_patient_request.dart';
import 'package:http/http.dart' as http;

class CentersHome extends StatefulWidget {
  final String centerEmail;

  const CentersHome({super.key, required this.centerEmail});

  @override
  State<CentersHome> createState() => _CentersHome();
}

class _CentersHome extends State<CentersHome> {
  bool isEditing = false;
  bool receiveOffers = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController centerNameController = TextEditingController();
  TextEditingController centerContactNumber = TextEditingController();
  // TextEditingController centerEmailAddress = TextEditingController();
  TextEditingController centerAddressOne = TextEditingController();
  TextEditingController centerAddressTwo = TextEditingController();
  TextEditingController centerOpiningHours = TextEditingController();
  TextEditingController centerOpiningDays = TextEditingController();

  TextEditingController centerContactName = TextEditingController();
  TextEditingController centerContractPosition = TextEditingController();
  TextEditingController centerDescription = TextEditingController();
  TextEditingController centerWebsite = TextEditingController();
  TextEditingController urlLogoImage = TextEditingController();
  TextEditingController centerLocation = TextEditingController();
  TextEditingController pricePerDay = TextEditingController();
  TextEditingController pricePerMonth = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch the user's name when the widget is created
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
          urlLogoImage.text = userData["URL Logo Image"] ?? "";
          centerLocation.text = userData["Center Location"] ?? "";
          pricePerDay.text = userData["Price Per Day"] ?? "";
          pricePerMonth.text = userData["Price Per Month"] ?? "";
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
                    initialValue: widget.centerEmail.isNotEmpty
                        ? widget.centerEmail
                        : "Guest",
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
                      controller: centerOpiningDays,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Business Days',
                      )),
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

                    //   if (!isValidOperatingHours12HourFormat(value)) {
                    //     return 'Invalid operating hours format. Please enter in hh:mm AM/PM - hh:mm AM/PM format';
                    //   }

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
                    "Prices",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    // keyboardAppearance: ,
                    enabled: isEditing,
                    controller: pricePerDay,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price Per day',
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
                    controller: pricePerMonth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price Per month',
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
                                // CollectionReference centers = FirebaseFirestore
                                //     .instance
                                //     .collection('centers');
                                // centers.add({
                                //   'Center Name': centerNameController.text,
                                //   'Center phone number':
                                //       centerNameController.text,
                                //   'Center Email Address':
                                //       centerEmailAddress.text,
                                //   'Center Address 1': centerAddressOne.text,
                                //   'Center Address 2': centerAddressTwo.text,
                                //   'Center operating Hours':
                                //       centerOpiningHours.text,
                                //   'Contact Center name': centerContactName.text,
                                //   'Contact Center position':
                                //       centerContractPosition.text,
                                //   'Contact Description': centerDescription.text,
                                //   'Contact website': centerWebsite.text,
                                //   'URL Logo Image': urlLogoImage.text,
                                // });
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
                                            _submitUserData();
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
                              checkImageValidity();
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
        var userId = documentSnapshot.id;

        // Add new fields to the existing document
        await centers.doc(userId).set({
          'Center Name': centerNameController.text,
          'Center phone number': centerContactNumber.text,
          'Center Address 1': centerAddressOne.text,
          'Center Address 2': centerAddressTwo.text,
          'Center operating Hours': centerOpiningHours.text,
          'Center operating Days': centerOpiningDays.text,
          'Contact Center name': centerContactName.text,
          'Contact Center position': centerContractPosition.text,
          'Center Description': centerDescription.text,
          'Center website': centerWebsite.text,
          'URL Logo Image': urlLogoImage.text,
          'Center Location': centerLocation.text,
          'Price Per Day': pricePerDay.text,
          'Price Per Month': pricePerMonth.text,
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

  Future<bool> isImageLinkValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void checkImageValidity() async {
    String imageUrl = urlLogoImage.text;
    bool isValid = await isImageLinkValid(imageUrl);

    if (isValid) {
      // The image link is valid, perform your desired action.
      print("Image link is valid!");
      print(isValid);
    } else {
      // The image link is not valid, handle the error or take appropriate action.
      print("Image link is not valid!++++++++");
    }
  }
}
