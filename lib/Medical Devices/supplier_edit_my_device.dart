import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';

class SupplierEditMyDevice extends StatefulWidget {
  final String supplierEmail;
  final String deviceName;
  final String devicePrice;
  final String deviceRent;
  final String deviceDescription;
  final bool deviceAavailability;
  final String deviceInstruction;
  final String deviceImage1;
  final String deviceImage2;
  final String deviceImage3;
  final String deviceId;

  const SupplierEditMyDevice({
    super.key,
    required this.deviceName,
    required this.devicePrice,
    required this.deviceRent,
    required this.deviceDescription,
    required this.deviceInstruction,
    required this.deviceImage1,
    required this.deviceImage2,
    required this.deviceImage3,
    required this.supplierEmail,
    required this.deviceId,
    required this.deviceAavailability,
  });

  @override
  State<SupplierEditMyDevice> createState() => _SupplierMyDevicesDetailsState();
}

class _SupplierMyDevicesDetailsState extends State<SupplierEditMyDevice> {
  Uint8List? _device1;
  Uint8List? _device2;
  Uint8List? _device3;

  String? deviceSellingOptions;
  late bool? _isAvailable;

  void selectDeviceImage1() async {
    Uint8List img1 = await pickImage(ImageSource.gallery);
    setState(() {
      _device1 = img1;
    });
  }

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

  late TextEditingController deviceName;
  late TextEditingController devicePriceForPuy;
  late TextEditingController deviceDescription;
  late TextEditingController devicePriceForRent;
  late TextEditingController deviceInstructions;

  @override
  void initState() {
    // Initialize controllers with the initial values
    deviceName = TextEditingController(text: widget.deviceName);
    devicePriceForPuy = TextEditingController(text: widget.devicePrice);
    devicePriceForRent = TextEditingController(text: widget.deviceRent);
    deviceDescription = TextEditingController(text: widget.deviceDescription);
    deviceInstructions = TextEditingController(text: widget.deviceInstruction);

    // Initialize _isAvailable with the widget's availability value
    _isAvailable = widget.deviceAavailability;

    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers
    deviceName.dispose();
    devicePriceForPuy.dispose();
    deviceDescription.dispose();
    devicePriceForRent.dispose();
    deviceInstructions.dispose();

    super.dispose();
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
            "Edit Device",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          : widget.deviceImage1.isNotEmpty
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(widget.deviceImage1),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromARGB(255, 201, 198, 198),
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.black),
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
                          : widget.deviceImage2.isNotEmpty
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(widget.deviceImage2),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromARGB(255, 201, 198, 198),
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.black),
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
                          : widget.deviceImage3.isNotEmpty
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(widget.deviceImage3),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromARGB(255, 201, 198, 198),
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.black),
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
                buildTextFormField(deviceDescription, "Description"),
                Text(
                  'Is the device available?',
                  style: TextStyle(fontSize: 18),
                ),
                ListTile(
                  title: const Text('Available'),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: _isAvailable,
                    activeColor: Color(0xFF1C8892),
                    onChanged: (bool? value) {
                      setState(() {
                        _isAvailable = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Unavailable'),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: _isAvailable,
                    activeColor: Color(0xFF1C8892),
                    onChanged: (bool? value) {
                      setState(() {
                        _isAvailable = value!;
                      });
                    },
                  ),
                ),
                buildTextFormField(
                    deviceInstructions, "Instructions about device"),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  dropdownColor: Color(0xFF1C8892),
                  value: deviceSellingOptions,
                  onChanged: (newValue) {
                    setState(
                      () {
                        deviceSellingOptions = newValue;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFF1C8892), width: 2.0),
                    ),
                    labelText: "Device selling options",
                    labelStyle: TextStyle(color: Color(0xFF1C8892)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  items: <String>[
                    'Rent',
                    'Buy',
                  ]
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 10),
                deviceSellingOptions == "Buy" || deviceSellingOptions == "Both"
                    ? TextFormField(
                        controller: devicePriceForPuy,
                        cursorColor: Color(0xFF1C8892),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF1C8892), width: 2.0),
                          ),
                          hintText: "Device Price",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      )
                    : Container(),
                SizedBox(height: 10),
                deviceSellingOptions == "Rent" || deviceSellingOptions == "Both"
                    ? TextFormField(
                        controller: devicePriceForRent,
                        cursorColor: Color(0xFF1C8892),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF1C8892), width: 2.0),
                          ),
                          hintText: "Device Price for rent per week",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      )
                    : Container(),
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
              updateDeviceData();
              // print(_isAvailable);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Edit Device",
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

  Future<void> updateDeviceData() async {
    try {
      // Update text data in Firestore
      await FirebaseFirestore.instance
          .collection('Devices')
          .doc(widget.deviceId)
          .update({
        'Device_Name': deviceName.text,
        'devicePriceForPuy': devicePriceForPuy.text,
        'devicePriceForRent': devicePriceForRent.text,
        'deviceDescription': deviceDescription.text,
        'deviceInstructions': deviceInstructions.text,
        'Device_availability': _isAvailable,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "${deviceName.text} Data updated successfully!",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to update device: $e",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }
}
