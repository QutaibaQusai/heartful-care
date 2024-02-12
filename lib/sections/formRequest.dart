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
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusColor:
                                      Color(0xFF1C8892), // Change focus color
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: Color(0xFF1C8892), // Change focus color
                            hintText: 'Phone Number',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: Color(0xFF1C8892), // Change focus color
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusColor:
                                      Color(0xFF1C8892), // Change focus color
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
                                  focusColor:
                                      Color(0xFF1C8892), // Change focus color
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: Color(0xFF1C8892), // Change focus color
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
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
                        Text("why do you need naris"),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey[300],
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
}
