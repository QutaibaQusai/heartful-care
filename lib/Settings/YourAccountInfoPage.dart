import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YourAccountInfoPage extends StatefulWidget {
  const YourAccountInfoPage({Key? key}) : super(key: key);

  @override
  State<YourAccountInfoPage> createState() => _YourAccountInfoPageState();
}

class _YourAccountInfoPageState extends State<YourAccountInfoPage> {
  bool isEditing = false;
  DateTime? selectedDate;
  String? selectedGender;
  bool receiveOffers = false;
  final fullNameTextController = TextEditingController();
  final PhoneNumberTextController = TextEditingController();
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

  void _deleteAccount() {
    // Add your delete account logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                  controller: fullNameTextController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 16),
              TextField(
                controller: PhoneNumberTextController,
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Date of birth (optional)',
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Icon(
                      Icons.calendar_today,
                      color:
                          Color(0xFF1C8892), // Change the calendar icon color
                    ),
                  ),
                ),
                controller: TextEditingController(
                  text: selectedDate != null
                      ? formatDate(selectedDate!, [dd, '/', mm, '/', yyyy])
                      : "",
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nationalIdTextController,
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'National ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Gender (optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
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
              SizedBox(height: 16),
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
                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('users');
                                users.add({
                                  'Fullname': fullNameTextController.text,
                                  'Phone Number':
                                      PhoneNumberTextController.text,
                                  'NationalID': nationalIdTextController.text,
                                  'DateOfBirth': dateOfBirthTextController.text,
                                  'Gender': selectedGender,
                                });
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Color(0xFF1C8892)),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'No',
                                style: TextStyle(color: Color(0xFF1C8892)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the border radius as needed
                      side: BorderSide(
                          color: Color(0xFF1C8892)), // Set the outline color
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Color(0xFF1C8892)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
