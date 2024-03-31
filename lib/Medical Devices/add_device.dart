import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';
import 'package:test/utils/storeImg%20.dart';

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
              _submitDeviceData();
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
        // Add device information along with image URLs to Firestore
        await devices.doc(deviceId).set({
          'DeviseId': deviceId,
          'Device_Name': deviceName.text,
          'devicePriceForPuy': devicePriceForPuy.text,
          'devicePriceForRent': devicePriceForRent.text,
          'deviceDescription': deviceDescription.text,
          'deviceQuantity': deviceQuantity.text,
          'deviceInstructions': deviceInstructions.text,
          'supplierId': supplierId,
          'Email': widget.supplierEmail,
          'ImageUrls': imageUrls, // Include image URLs in Firestore document
        });

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
