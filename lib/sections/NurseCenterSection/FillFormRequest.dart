// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/NurseCenterSection/checkout_nurseCenter.dart';
import 'package:test/sections/NurseCenterSection/multiSelect.dart';

class FormRequest extends StatefulWidget {
  final String userEmail;
  final String centerId;
  final String centerName;
  final String centerAddress1;
  final String checkup;
  final String pricePerDay;

  const FormRequest({
    Key? key,
    required this.userEmail,
    required this.centerId,
    required this.centerName,
    required this.centerAddress1,
    required this.checkup,
    required this.pricePerDay,
  }) : super(key: key);

  @override
  State<FormRequest> createState() => _FormRequestState();
}

class _FormRequestState extends State<FormRequest> {
  double deliveryFee = 1;
  double total = 0.0;

  int selectedPaymentPerDay = 1;
  bool selectedPaymentOptionQuicklyCheckups = false;
  bool selectedPaymentOptionPerDay = false;

  String? selectedGender;
  bool? hasAllergies;
  bool? isWalk;
  bool? historyOfSurgeries;
  TextEditingController patientFirstName = TextEditingController();
  TextEditingController patientLastName = TextEditingController();
  TextEditingController patientPhoneNumber = TextEditingController();
  TextEditingController patientAge = TextEditingController();
  TextEditingController patientAddress = TextEditingController();
  List<String> selectedItem = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
            child: Column(children: [
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
                              value: selectedGender,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedGender = newValue;
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
                                    (String value) => DropdownMenuItem<String>(
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
              SizedBox(height: 10),
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
                      SizedBox(height: 10),
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
                                groupValue: hasAllergies,
                                onChanged: (value) {
                                  setState(() {
                                    hasAllergies = value;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('Yes'),
                              Radio<bool>(
                                value: false,
                                groupValue: hasAllergies,
                                onChanged: (value) {
                                  setState(() {
                                    hasAllergies = value;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('No'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                                groupValue: isWalk,
                                onChanged: (value) {
                                  setState(() {
                                    isWalk = value;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('Yes'),
                              Radio<bool>(
                                value: false,
                                groupValue: isWalk,
                                onChanged: (value) {
                                  setState(() {
                                    isWalk = value;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('No'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                                groupValue: historyOfSurgeries,
                                onChanged: (value) {
                                  setState(() {
                                    historyOfSurgeries = value;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('Yes'),
                              Radio<bool>(
                                value: false,
                                groupValue: historyOfSurgeries,
                                onChanged: (value) {
                                  setState(() {
                                    historyOfSurgeries = value;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text('No'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _showMultiSelect();
                        },
                        child: Text(
                          "Why do you need a nurse?",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF1C8892),
                          ),
                        ),
                      ),
                      Wrap(
                        children: selectedItem
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
                                  text: selectedDate != null
                                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
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
                                  text: selectedTime != null
                                      ? '${selectedTime!.format(context)}'
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
                      SizedBox(height: 10),
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
                              Radio<bool>(
                                value: true,
                                groupValue:
                                    selectedPaymentOptionQuicklyCheckups,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOptionQuicklyCheckups =
                                        value!;
                                    selectedPaymentOptionPerDay = false;
                                  });
                                },
                                activeColor: Color(0xFF1C8892),
                              ),
                              Text(
                                'Quickly checkups ',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: selectedPaymentOptionPerDay,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOptionPerDay = value!;
                                    selectedPaymentOptionQuicklyCheckups =
                                        false;
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
            ]),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // _saveFormDataToFirestore();

              _calculateTotal();
              print('Total before navigation: $total');
              Navigator.push(
                context,
                _createRightToLeftRoute(
                  CheckoutNurseCenter(
                    centerName: widget.centerName,
                    centerAddress1: widget.centerAddress1,
                    userEmail: widget.userEmail,
                    subtotal: total,
                    deliveryFee: deliveryFee,
                    total: total,
                    centerId: widget.centerId,
                    patientFirstName: patientFirstName.text,
                    patientLastName: patientLastName.text,
                    patientPhoneNumber: patientPhoneNumber.text,
                    age: patientAge.text,
                    gender: selectedGender!,
                    address: patientAddress.text,
                    hasAllergies: hasAllergies!,
                    isWalk: isWalk!,
                    historyOfSurgeries: historyOfSurgeries!,
                    needNurse: selectedItem,
                    selectedDate: selectedDate!,
                    selectedTime: selectedTime!,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Continue to checkout".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.transparent))),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF1C8892),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _calculateTotal() {
    try {
      double subtotal = 0.0;

      if (selectedPaymentOptionQuicklyCheckups) {
        String price = widget.checkup.replaceAll(RegExp('[^0-9.]'), '');
        subtotal = double.parse(price);
      } else if (selectedPaymentOptionPerDay) {
        subtotal = selectedPaymentPerDay * double.parse(widget.pricePerDay);
      }

      if (selectedPaymentOptionQuicklyCheckups || selectedPaymentOptionPerDay) {
        total = subtotal;
      } else {
        total = 0.0;
      }

      print('Total: $total');
    } catch (e) {
      print('Error calculating total: $e');
      total = 0.0;
    }
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
          selectedItems: selectedItem, // Pass selected items to MutiSelect
        );
      },
    );

    if (results != null) {
      setState(() {
        selectedItem = results;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
    String formattedTime = selectedTime!.format(context);
    setState(() {
      selectedTime = TimeOfDay.fromDateTime(DateTime.parse(formattedTime));
    });
  }

  Route _createRightToLeftRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  // void _saveFormDataToFirestore() async {
  //   String? userId = FirebaseAuth.instance.currentUser?.uid;
  //   if (userId == null || userId.isEmpty) {
  //     print('User ID is missing');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Color(0xFF1C8892),
  //         content: Text('You need to be logged in to submit a form.'),
  //       ),
  //     );
  //     return;
  //   }

  //   try {
  //     // Initialize the form data map
  //     Map<String, dynamic> formData = {
  //       'user_id': userId,
  //       'center_id': widget.centerId,
  //       'firstName': patientFirstName.text,
  //       'lastName': patientLastName.text,
  //       'phoneNumber': patientPhoneNumber.text,
  //       'age': int.tryParse(patientAge.text) ?? 0,
  //       'gender': _selectedGender ?? "",
  //       'address': patientAddress.text,
  //       'hasAllergies': _hasAllergies ?? false,
  //       'isWalk': _isWalk ?? false,
  //       'historyOfSurgeries': _historyOfSurgeries ?? false,
  //       'needNurse': _selectedItem,
  //       'date':
  //           _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
  //       'time': _selectedTime != null ? _selectedTime!.format(context) : null,
  //       'selectedPaymentOptionQuicklyCheckups':
  //           selectedPaymentOptionQuicklyCheckups,
  //     };

  //     // Conditionally add the 'selectedPaymentPerDay' field
  //     if (selectedPaymentOptionQuicklyCheckups == "quickly checkups") {
  //       formData['selectedPaymentPerDay'] = "none";
  //     } else {
  //       formData['selectedPaymentPerDay'] = selectedPaymentOptionPerDay;
  //     }

  //     await FirebaseFirestore.instance.collection('form_request').add(formData);
  //     Navigator.of(context).pop();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Color(0xFF1C8892),
  //         content: Text('Form data saved successfully!'),
  //       ),
  //     );
  //   } catch (e) {
  //     print('Error saving form data: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Color(0xFF1C8892),
  //         content: Text('Error saving form data. Please try again later.'),
  //       ),
  //     );
  //   }
  // }
}
