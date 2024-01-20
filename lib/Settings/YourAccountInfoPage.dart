import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class YourAccountInfoPage extends StatefulWidget {
  final String userEmail;

  const YourAccountInfoPage({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<YourAccountInfoPage> createState() => _YourAccountInfoPageState();
}

class _YourAccountInfoPageState extends State<YourAccountInfoPage> {
  String userName = ""; // Store the user's name
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch the user's name when the widget is created
  }

  // void fetchUserEmail() async {
  //   try {
  //     var userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('email', isEqualTo: widget.userEmail)
  //         .get();

  //     if (userDoc.docs.isNotEmpty) {
  //       setState(() {});
  //       userName = userDoc.docs[0]['fullname'];
  //     }
  //   } catch (e) {
  //     print('Error fetching user data: $e');
  //   }
  // }
  void fetchUserData() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        var userData = userDoc.docs[0].data();

        setState(() {
          fullNameTextController.text = userData['fullname'] ?? "";
          phoneNumberTextController.text = userData['Phone Number'] ?? "";
          nationalIdTextController.text = userData['NationalID'] ?? "";

          // Parse the date string if available
          if (userData['DateOfBirth'] != null) {
            selectedDate = DateTime.parse(userData['DateOfBirth']);
            dateOfBirthTextController.text = formatDate(
              selectedDate!,
              [dd, '/', mm, '/', yyyy],
            );
          }

          selectedGender = userData['Gender'] ?? "";
          receiveOffers = userData['ReceiveOffers'] ?? false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  bool isEditing = false;
  DateTime? selectedDate;
  String? selectedGender;
  bool receiveOffers = false;
  final fullNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final nationalIdTextController = TextEditingController();
  final dateOfBirthTextController = TextEditingController();
  final genderTextController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showCustomDatePicker(context);

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirthTextController.text = formatDate(
          picked,
          [dd, '/', mm, '/', yyyy],
        );
      });
    }
  }

  Future<DateTime?> showCustomDatePicker(BuildContext context) async {
    DateTime? initialDate = selectedDate ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF1C8892),
            // accentColor: Color(0xFF1C8892),
            colorScheme: ColorScheme.light(primary: Color(0xFF1C8892)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Account info',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Spacer(), // Add some space between the title and "Edit"
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
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: widget.userEmail.isNotEmpty
                        ? widget.userEmail
                        : "Guest",
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: isEditing
                          ? TextStyle(color: Colors.black)
                          : TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                  // Text(widget.userEmail),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: fullNameTextController,
                    enabled: isEditing,
                    decoration: InputDecoration(
                      labelText: 'Full name',
                      labelStyle: isEditing
                          ? TextStyle(color: Colors.black)
                          : TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
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

                  SizedBox(height: 16),
                  TextFormField(
                    cursorColor: Color(0xFF1C8892),
                    keyboardType: TextInputType.number,
                    controller: phoneNumberTextController,
                    enabled: isEditing,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: isEditing
                          ? TextStyle(color: Colors.black)
                          : TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
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
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                      enabled: isEditing,
                      decoration: InputDecoration(
                        labelText: 'Date of birth (optional)',
                        labelStyle: isEditing
                            ? TextStyle(color: Colors.black)
                            : TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0xFF1C8892),
                            // Change the calendar icon color
                          ),
                        ),
                      ),
                      controller: TextEditingController(
                        text: selectedDate != null
                            ? formatDate(
                                selectedDate!, [dd, '/', mm, '/', yyyy])
                            : "",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Date of birth";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: nationalIdTextController,
                    // initialValue: nationalIdTextController.text,
                    cursorColor: Color(0xFF1C8892),
                    keyboardType: TextInputType.number,
                    enabled: isEditing,
                    decoration: InputDecoration(
                      labelText: 'National ID',
                      labelStyle: isEditing
                          ? TextStyle(color: Colors.black)
                          : TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[0-9]+$').hasMatch(value) ||
                          value.length != 10) {
                        return "Please enter your national id number correctly ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Gender (optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: isEditing
                                ? (value) {
                                    setState(() {
                                      selectedGender = value as String?;
                                    });
                                  }
                                : null,
                            activeColor: Color(0xFF1C8892),
                          ),
                          Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Female',
                            groupValue: selectedGender,
                            onChanged: isEditing
                                ? (value) {
                                    setState(() {
                                      selectedGender = value as String?;
                                    });
                                  }
                                : null,
                            activeColor: Color(0xFF1C8892),
                          ),
                          Text('Female'),
                        ],
                      ),
                    ],
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
                      Text('Yes, I want to receive offers and discounts'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Confirm deletion
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Submit your data',
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF1C8892)),
                                ),
                                content: Text(
                                    'Are you sure you want to submit your data?'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      await _submitUserData();
                                    },
                                    child: Text(
                                      'Yes',
                                      style:
                                          TextStyle(color: Color(0xFF1C8892)),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'No',
                                      style:
                                          TextStyle(color: Color(0xFF1C8892)),
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
                              color:
                                  Color(0xFF1C8892)), // Set the outline color
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF1C8892)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Find the user document
      var userDoc =
          await users.where('email', isEqualTo: widget.userEmail).get();

      if (userDoc.docs.isNotEmpty) {
        var userId = userDoc.docs[0].id;

        // Update the existing document with the new data
        await users.doc(userId).update({
          'fullname': fullNameTextController.text,
          'Phone Number': phoneNumberTextController.text,
          'NationalID': nationalIdTextController.text,
          'DateOfBirth':
              selectedDate != null ? selectedDate!.toIso8601String() : null,
          'Gender': selectedGender,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              ' User data updated successfully!',
              style: TextStyle(
                  fontSize: 17, fontFamily: GoogleFonts.poppins().fontFamily),
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
                  fontSize: 17, fontFamily: GoogleFonts.poppins().fontFamily),
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
                fontSize: 17, fontFamily: GoogleFonts.poppins().fontFamily),
          ),
        ),
      );
    }
  }
}
