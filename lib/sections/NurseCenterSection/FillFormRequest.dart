import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/NurseCenterSection/multiSelect.dart';

// for the payment option
enum PaymentOption { perHour, perDay, perMonth, none }

class FormRequest extends StatefulWidget {
  final String userEmail;
  final String centerId;

  const FormRequest({Key? key, required this.userEmail, required this.centerId})
      : super(key: key);

  @override
  State<FormRequest> createState() => _FormRequestState();
}

class _FormRequestState extends State<FormRequest> {
  String selectedPaymentOption = '';
  String? _selectedGender;
  bool? _hasAllergies;
  bool? _isWalk;
  bool? _historyOfSurgeries;
  // String? _needNurse;
  TextEditingController patientFirstName = TextEditingController();
  TextEditingController patientLastName = TextEditingController();
  TextEditingController patientPhoneNumber = TextEditingController();
  // TextEditingController patientEmail = TextEditingController();
  TextEditingController patientAge = TextEditingController();
  TextEditingController patientGender = TextEditingController();
  TextEditingController patientAddress = TextEditingController();
  List<String> _selectedItem = [];
  // payment option
  // PaymentOption _selectedPaymentOption = PaymentOption.none;
  // int? _numDays;
  // int? _numMonths;

  // for the date and time
  DateTime? _selectedDate;
  int selectedPaymentPerHour = 1;
  int selectedPaymentPerDay = 1;
  TimeOfDay? _selectedTime;

  // String _selectedHours = '1';
  // String _selectedDays = '1';
  @override
  void initState() {
    super.initState();
    // Wait for the widget tree to be built before showing the snackbar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Color(0xFF1C8892),
        //     content:
        //         Text('Your ID is: ' + FirebaseAuth.instance.currentUser!.uid),
        //   ),
        // );
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
    // Convert selected time to AM/PM format
    String formattedTime = _selectedTime!.format(context);
    setState(() {
      _selectedTime = TimeOfDay.fromDateTime(DateTime.parse(formattedTime));
    });
  }

  void _showMultiSelect() async {
    List<String> item = [
      'Routine medical care',
      'Elderly care',
      'Medication assistance',
      'Wound care',
      'Mobility assistance',
      'Post-hospitalization care',
      'Other'
    ];
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MutiSelect(
          items: item,
          selectedItems: _selectedItem, // Pass selected items to MutiSelect
        );
      },
    );

    if (results != null) {
      setState(() {
        _selectedItem = results;
      });
    }
  }

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
                          enabled: false,
                          initialValue: widget.userEmail.isNotEmpty
                              ? widget.userEmail
                              : "Gust",
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
                              "Does the patient rely on a wheelchair?",
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
                        ElevatedButton(
                          onPressed: () {
                            _showMultiSelect();
                          },
                          child: Text("Why do you need a nurse?",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF1C8892), // Button background color
                            ),
                          ),
                        ),
                        Wrap(
                          children: _selectedItem
                              .map(
                                (e) => Chip(
                                  label: Text(e),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Service details:".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: _selectedDate != null
                                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                        : '',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Select Date',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF1C8892), width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: _selectDate,
                                      icon: Icon(Icons.calendar_today),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: _selectedTime != null
                                        ? '${_selectedTime!.format(context)}'
                                        : '',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Select Time',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF1C8892), width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: _selectTime,
                                      icon: Icon(Icons.access_time),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Payment option: ".toUpperCase(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 'Per Hour',
                                  groupValue: selectedPaymentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentOption = value as String;
                                    });
                                  },
                                  activeColor: Color(0xFF1C8892),
                                ),
                                Text(
                                  ' quickly checkups',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 10),
                            
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Radio(
                                  value: 'Per Day',
                                  groupValue: selectedPaymentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentOption = value as String;
                                    });
                                  },
                                  activeColor: Color(0xFF1C8892),
                                ),
                                Text(
                                  'Per Day',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 10),
                                DropdownButton<int>(
                                  value: selectedPaymentPerDay,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedPaymentPerDay = value!;
                                    });
                                  },
                                  items: List.generate(30, (index) {
                                    return DropdownMenuItem<int>(
                                      value: index + 1,
                                      child: Text((index + 1).toString()),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
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
              _saveFormDataToFirestore();
              // Navigator.of(context).pop();
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
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || userId.isEmpty) {
      print('User ID is missing');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('You need to be logged in to submit a form.'),
        ),
      );
      return;
    }

    try {
      Map<String, dynamic> formData = {
        'user_id': userId,
        'center_id': widget.centerId,
        'firstName': patientFirstName.text,
        'lastName': patientLastName.text,
        'phoneNumber': patientPhoneNumber.text,
        'age': int.tryParse(patientAge.text) ?? 0,
        'gender': _selectedGender ?? "",
        'address': patientAddress.text,
        'hasAllergies': _hasAllergies ?? false,
        'isWalk': _isWalk ?? false,
        'historyOfSurgeries': _historyOfSurgeries ?? false,
        'needNurse': _selectedItem,
        'date':
            _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
        'time': _selectedTime != null ? _selectedTime!.format(context) : null,
        'selectedPaymentPerDay': selectedPaymentPerDay,
        'selectedPaymentPerHour': selectedPaymentPerHour,
      };

      await FirebaseFirestore.instance.collection('form_request').add(formData);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('Form data saved successfully!'),
        ),
      );
    } catch (e) {
      print('Error saving form data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text('Error saving form data. Please try again later.'),
        ),
      );
    }
  }
}
