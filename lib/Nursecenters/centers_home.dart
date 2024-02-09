import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CentersHome extends StatefulWidget {
  const CentersHome({super.key});

  @override
  State<CentersHome> createState() => _CentersHome();
}

class _CentersHome extends State<CentersHome> {
  bool isEditing = false;
  bool receiveOffers = false;
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
          title: Row(
            children: [
              Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Spacer(),
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
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  controller: centerNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter center name',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: centerContactNumber,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone Number',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: centerEmailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: urlLogoImage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'URL logo Image',
                  ),
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
                  controller: centerAddressOne,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address 1',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
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
                  controller: centerOpiningHours,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Business Hours',
                  ),
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
                  controller: centerContactName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: centerContractPosition,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Position',
                  ),
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
                  controller: centerDescription,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: centerWebsite,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Website',
                  ),
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
                            // Confirm deletion
                            CollectionReference centers = FirebaseFirestore
                                .instance
                                .collection('centers');
                            centers.add({
                              'Center Name': centerNameController.text,
                              'Center phone number': centerNameController.text,
                              'Center Email Address': centerEmailAddress.text,
                              'Center Address 1': centerAddressOne.text,
                              'Center Address 2': centerAddressTwo.text,
                              'Center operating Hours': centerOpiningHours.text,
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
                                        fontSize: 20, color: Color(0xFF1C8892)),
                                  ),
                                  content: Text(
                                      'Are you sure you want to submit your data?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {},
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
    );
  }
}
