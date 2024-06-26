import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';
import 'package:test/utils/storeImg%20.dart';

class SupplierAddDevice extends StatefulWidget {
  final String supplierEmail;

  const SupplierAddDevice({Key? key, required this.supplierEmail})
      : super(key: key);

  @override
  State<SupplierAddDevice> createState() => _Add_deviceState();
}

class _Add_deviceState extends State<SupplierAddDevice> {
  TextEditingController deviceName = TextEditingController();
  TextEditingController devicePriceForPuy = TextEditingController();
  TextEditingController devicePriceForRent = TextEditingController();
  TextEditingController deviceDescription = TextEditingController();
  TextEditingController deviceInstructions = TextEditingController();
  Uint8List? _device1;
  Uint8List? _device2;
  Uint8List? _device3;
  String? deviceSellingOptions;
  bool? _isAvailable;

  void selectDeviceImage1({required ImageSource galleryOrImage}) async {
    Uint8List img1 = await pickImage(galleryOrImage);
    setState(() {
      _device1 = img1;
    });
  }

  // Method to select the second image
  void selectDeviceImage2({required ImageSource galleryOrImage}) async {
    Uint8List img2 = await pickImage(galleryOrImage);
    setState(() {
      _device2 = img2;
    });
  }

  // Method to select the third image
  void selectDeviceImage3({required ImageSource galleryOrImage}) async {
    Uint8List img3 = await pickImage(galleryOrImage);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showImageSelectionBottomSheet(
                            isFirstImage: true, isSecondImage: false);
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
                        showImageSelectionBottomSheet(
                            isFirstImage: false, isSecondImage: true);
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
                        showImageSelectionBottomSheet(
                            isFirstImage: false, isSecondImage: false);
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
                buildTextFormField(deviceDescription, "Description"),
                // device quantaity
                //
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
                        _isAvailable = value;
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
                        _isAvailable = value;
                      });
                    },
                  ),
                ),

                //
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
                        // borderSide: const BorderSide(
                        //     color: Color(0xFF1C8892), width: 2.0),
                        ), // Change focus color
                    labelText: "Device selling options",
                    labelStyle: TextStyle(color: Colors.black),
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
                // buildTextFormField(
                //     devicePriceForRent, "Device Price for rent per week"),
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
              _submitDeviceData();
              print(deviceInstructions.text);
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

  Widget buildTextFormField(
      TextEditingController controller, String labelText) {
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
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Future<void> _submitDeviceData() async {
    try {
      CollectionReference devices =
          FirebaseFirestore.instance.collection('Devices');

      // Initialize StoreImg instance
      StoreImg storeImg = StoreImg();

      // Step 1: Generate a unique ID for the device
      String deviceId = devices.doc().id;

      QuerySnapshot supplierSnapshot = await FirebaseFirestore.instance
          .collection('Suppliers')
          .where('Email', isEqualTo: widget.supplierEmail)
          .get();

      if (supplierSnapshot.docs.isNotEmpty) {
        String supplierId = supplierSnapshot.docs.first.id;

        List<Uint8List> files = [];
        if (_device1 != null) files.add(_device1!);
        if (_device2 != null) files.add(_device2!);
        if (_device3 != null) files.add(_device3!);

        // Upload images and get URLs
        String storagePath = 'DeviceImages';
        List<String> imageUrls = await storeImg.uploadDeviceImages(
          files: files,
          supplierEmail: widget.supplierEmail,
          deviceName: deviceName.text,
          storagePath: storagePath,
        );

        // Create a map to hold device data
        Map<String, dynamic> deviceData = {
          'DeviseId': deviceId,
          'Device_Name': deviceName.text,
          'deviceDescription': deviceDescription.text,
          'Device_availability': _isAvailable,
          'deviceInstructions': deviceInstructions.text,
          'supplierId': supplierId,
          'Email': widget.supplierEmail,
          'ImageUrls': imageUrls,
          'devicePriceForRent': devicePriceForRent.text,
          'devicePriceForPuy': devicePriceForPuy.text
        };

        // // Conditionally add price fields as doubles

        // deviceData['devicePriceForPuy'] =
        //     double.parse(devicePriceForPuy.text);

        // deviceData['devicePriceForRent'] =
        //     double.parse(devicePriceForRent.text);

        // Add device information along with image URLs to Firestore
        await devices.doc(deviceId).set(deviceData);
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Device added successfully!',
              style: TextStyle(fontSize: 17),
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
              style: TextStyle(fontSize: 17),
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
            'Error adding device: $e',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }

  void showImageSelectionBottomSheet(
      {required bool isFirstImage, required bool isSecondImage}) {
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
                    if (isFirstImage) {
                      selectDeviceImage1(galleryOrImage: ImageSource.gallery);
                    } else if (isSecondImage) {
                      selectDeviceImage2(galleryOrImage: ImageSource.gallery);
                    } else {
                      selectDeviceImage3(galleryOrImage: ImageSource.gallery);
                    }
                    Navigator.pop(context); // Close the bottom sheet
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
                    if (isFirstImage) {
                      selectDeviceImage1(galleryOrImage: ImageSource.camera);
                    } else if (isSecondImage) {
                      selectDeviceImage2(galleryOrImage: ImageSource.camera);
                    } else {
                      selectDeviceImage3(galleryOrImage: ImageSource.camera);
                    }
                    Navigator.pop(context); // Close the bottom sheet
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
