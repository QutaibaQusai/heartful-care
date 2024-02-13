import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormRequest extends StatefulWidget {
  const FormRequest({Key? key}) : super(key: key);

  @override
  State<FormRequest> createState() => _FormRequestState();
}

class _FormRequestState extends State<FormRequest> {
  String? _selectedGender;
  bool? _hasAllergies;
  bool? _isWalk;
  bool? _historyOfSurgeries;
  String? _needNurse;
  TextEditingController patientFirstName = TextEditingController();
  TextEditingController patientLastName = TextEditingController();
  TextEditingController patientPhoneNumber = TextEditingController();
  TextEditingController patientEmail = TextEditingController();
  TextEditingController patientAge = TextEditingController();
  TextEditingController patientGender = TextEditingController();
  TextEditingController patientAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          shadowColor: Colors.transparent,
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
          title: Text(
            "Medical Form",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Patient Information:".toUpperCase(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: patientFirstName,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF1C8892), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'First Name',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: patientLastName,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF1C8892), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ), // Change focus color
                                  hintText: 'Last Name',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: patientPhoneNumber,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF1C8892), width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ), // Change focus color
                            hintText: 'Phone Number',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: patientEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF1C8892), width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: patientAge,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF1C8892), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ), // Change focus color
                                  hintText: 'Age',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedGender,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedGender = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF1C8892), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ), // Change focus color
                                  hintText: 'Gender',
                                ),
                                items: <String>['Male', 'Female']
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: patientAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF1C8892), width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Address',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medical Information:".toUpperCase(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Do you have any allergies?",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: _hasAllergies,
                                  onChanged: (value) {
                                    setState(() {
                                      _hasAllergies = value;
                                    });
                                  },
                                  activeColor: Color(
                                      0xFF1C8892), // Change radio button color
                                ),
                                Text('Yes'),
                                Radio<bool>(
                                  value: false,
                                  groupValue: _hasAllergies,
                                  onChanged: (value) {
                                    setState(() {
                                      _hasAllergies = value;
                                    });
                                  },
                                  activeColor: Color(
                                      0xFF1C8892), // Change radio button color
                                ),
                                Text('No'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Is the patient able to walk, or do they use a wheelchair?",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: _isWalk,
                                  onChanged: (value) {
                                    setState(() {
                                      _isWalk = value;
                                    });
                                  },
                                  activeColor: Color(
                                      0xFF1C8892), // Change radio button color
                                ),
                                Text('Yes'),
                                Radio<bool>(
                                  value: false,
                                  groupValue: _isWalk,
                                  onChanged: (value) {
                                    setState(() {
                                      _isWalk = value;
                                    });
                                  },
                                  activeColor: Color(
                                      0xFF1C8892), // Change radio button color
                                ),
                                Text('No'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Do you have a history of surgeries?",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: _historyOfSurgeries,
                                  onChanged: (value) {
                                    setState(() {
                                      _historyOfSurgeries = value;
                                    });
                                  },
                                  activeColor: Color(
                                      0xFF1C8892), // Change radio button color
                                ),
                                Text('Yes'),
                                Radio<bool>(
                                  value: false,
                                  groupValue: _historyOfSurgeries,
                                  onChanged: (value) {
                                    setState(() {
                                      _historyOfSurgeries = value;
                                    });
                                  },
                                  activeColor: Color(
                                      0xFF1C8892), // Change radio button color
                                ),
                                Text('No'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Why do you need a nurse?",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              value: _needNurse,
                              onChanged: (newValue) {
                                setState(() {
                                  _needNurse = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF1C8892),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Nurse for',
                                fillColor: Colors.grey[
                                    100], // Dropdown button background color
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Dropdown item text color
                              ),
                              items: <String>[
                                'Routine medical care',
                                'Elderly care',
                                'Medication assistance',
                                'Wound care',
                                'Mobility assistance',
                                'Post-hospitalization care',
                                'Other'
                              ]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.transparent))),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF1C8892), // Button background color
              ),
            ),
            onPressed: () {
              // TODO: Implement button onPressed logic
              _saveFormDataToFirestore();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Continue to confirm".toUpperCase(),
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

  void _saveFormDataToFirestore() async {
    try {
      // Get form data from text controllers
      String firstName = patientFirstName.text;
      String lastName = patientLastName.text;
      String phoneNumber = patientPhoneNumber.text;
      String email = patientEmail.text;
      int age = int.tryParse(patientAge.text) ?? 0;
      String gender = _selectedGender ?? "";
      String address = patientAddress.text;

      // Create a map representing the form data
      Map<String, dynamic> formData = {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'age': age,
        'gender': gender,
        'address': address,
        'hasAllergies': _hasAllergies ?? false,
        'isWalk': _isWalk ?? false,
        'historyOfSurgeries': _historyOfSurgeries ?? "",
        'needNurse': _needNurse ?? "",
        // Add more fields as needed
      };

      // Save form data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc('user_id')
          .collection('form_request')
          .add(formData);

      // Show success message or navigate to next screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Form data saved successfully!'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      // Handle errors
      print('Error saving form data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving form data. Please try again later.'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
