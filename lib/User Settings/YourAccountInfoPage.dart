import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';
import 'package:test/utils/storeImg%20.dart';

class YourAccountInfoPage extends StatefulWidget {
  final String userEmail;

  const YourAccountInfoPage({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<YourAccountInfoPage> createState() => _YourAccountInfoPageState();
}

class _YourAccountInfoPageState extends State<YourAccountInfoPage> {
  Uint8List? _profileImageUser;
  String? userProfile;

  void selectProfileImageSupplier(
      {required ImageSource galleryOrCamera}) async {
    Uint8List img = await pickImage(galleryOrCamera);
    setState(
      () {
        _profileImageUser = img;
      },
    );
  }

  void saveUserProfile() async {
    StoreImg().saveUserProfile(
        file: _profileImageUser!,
        supplierEmail: widget.userEmail,
        storagePath: 'usersProfile',
        firestoreCollectionName: 'users',
        supplierFireStoreFiledName: 'users_profile');
  }

  String userName = ""; // Store the user's name
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch the user's name when the widget is created
  }

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
          userProfile = userData['users_profile'];
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
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
          leading: Container(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              ),
            ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.red,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 4,
                                    color: Color(0xFF1C8892),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1))
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width /
                                          3 /
                                          2), // Make the container circular
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width /
                                          3 /
                                          2), // Make the image circular
                                  child: _profileImageUser != null
                                      ? Image(
                                          image: MemoryImage(
                                            _profileImageUser!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : userProfile != null
                                          ? Image(
                                              image: NetworkImage(
                                                userProfile!,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : Image(
                                              image: AssetImage(
                                                "images/profile.webp",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    isEditing, // This will make the Positioned widget visible when isEditing is false
                                child: Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(),
                                    child: IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        showImageSelectionBottomSheet();
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                    maxLength: 10,
                    cursorColor: Color(0xFF1C8892),
                    keyboardType: TextInputType.number,
                    controller: phoneNumberTextController,
                    enabled: isEditing,
                    autocorrect: false,
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
                    maxLength: 10,
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
                      Text(
                        'Yes, I want to receive offers and discounts',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: !isEditing
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                // Confirm deletion
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
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                            await _submitUserData();
                                            saveUserProfile();
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
                    selectProfileImageSupplier(
                        galleryOrCamera: ImageSource.gallery);
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
                    selectProfileImageSupplier(
                        galleryOrCamera: ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
