import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';

class Add_device extends StatefulWidget {
  final String supplierEmail;

  const Add_device({Key? key, required this.supplierEmail}) : super(key: key);

  @override
  State<Add_device> createState() => _Add_deviceState();
}

class _Add_deviceState extends State<Add_device> {
  TextEditingController deviceName = TextEditingController();
  TextEditingController devicePriceForPuy = TextEditingController();
  TextEditingController devicePriceForRent = TextEditingController();
  TextEditingController deviceDescription = TextEditingController();
  TextEditingController deviceQuantity = TextEditingController();
  TextEditingController deviceInstructions = TextEditingController();
  Uint8List? _device1;
  Uint8List? _device2;
  Uint8List? _device3;

  void selectDeviceImage1() async {
    Uint8List img1 = await pickImage(ImageSource.gallery);
    setState(() {
      _device1 = img1;
    });
  }

  // Method to select the second image
  void selectDeviceImage2() async {
    Uint8List img2 = await pickImage(ImageSource.gallery);
    setState(() {
      _device2 = img2;
    });
  }

  // Method to select the third image
  void selectDeviceImage3() async {
    Uint8List img3 = await pickImage(ImageSource.gallery);
    setState(() {
      _device3 = img3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Add Device",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectDeviceImage1();
                      },
                      child: _device1 != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(_device1!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Color.fromARGB(255, 201, 198, 198),
                              child:
                                  Icon(Icons.camera_alt, color: Colors.black),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectDeviceImage2();
                      },
                      child: _device2 != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(_device2!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Color.fromARGB(255, 201, 198, 198),
                              child:
                                  Icon(Icons.camera_alt, color: Colors.black),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectDeviceImage3();
                      },
                      child: _device3 != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(_device3!),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Color.fromARGB(255, 201, 198, 198),
                              child:
                                  Icon(Icons.camera_alt, color: Colors.black),
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Device Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                buildTextFormField(deviceName, "Device Name"),
                buildTextFormField(devicePriceForPuy, "Device Price"),
                buildTextFormField(
                    devicePriceForRent, "Device Price for rent per week"),
                buildTextFormField(deviceDescription, "Description"),
                buildTextFormField(deviceQuantity, "Device quantity"),
                buildTextFormField(
                    deviceInstructions, "Instructions about device"),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1C8892),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              _submitUserData();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Add Device",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          cursorColor: Color(0xFF1C8892),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFF1C8892), width: 2.0),
            ),
            hintText: hintText,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Future<void> _submitUserData() async {
    try {
      CollectionReference devices =
          FirebaseFirestore.instance.collection('Devices');

      // Retrieve the supplier ID based on the supplierEmail
      //save the supplier id with the data of the device
      QuerySnapshot supplierSnapshot = await FirebaseFirestore.instance
          .collection('Suppliers')
          .where('Email', isEqualTo: widget.supplierEmail)
          .get();

      if (supplierSnapshot.docs.isNotEmpty) {
        String supplierId = supplierSnapshot.docs.first.id;

        // Check if device already exists
        var existingDevice = await devices
            .where('Device_Name', isEqualTo: deviceName.text)
            .get();

        if (existingDevice.docs.isNotEmpty) {
          // Update existing device
          var existingDeviceId = existingDevice.docs[0].id;
          await devices.doc(existingDeviceId).update({
            'devicePriceForPuy': devicePriceForPuy.text,
            'devicePriceForRent': devicePriceForRent.text,
            'deviceDescription': deviceDescription.text,
            'deviceQuantity': deviceQuantity.text,
            'deviceInstructions': deviceInstructions.text,
            'supplierId': supplierId, // Include the supplier ID here
          });
        } else {
          // Add new device
          await devices.add({
            'Device_Name': deviceName.text,
            'devicePriceForPuy': devicePriceForPuy.text,
            'devicePriceForRent': devicePriceForRent.text,
            'deviceDescription': deviceDescription.text,
            'deviceQuantity': deviceQuantity.text,
            'deviceInstructions': deviceInstructions.text,
            'supplierId': supplierId, // Include the supplier ID here
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Device data updated successfully!',
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
              'Supplier not found!',
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
            'Error updating device data: $e',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }
}
