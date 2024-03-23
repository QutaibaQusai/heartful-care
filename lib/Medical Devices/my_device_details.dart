import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/pickImage.dart';
import 'package:test/utils/storeImg%20.dart';

class MyDeviceDetails extends StatefulWidget {
  final String supplierEmail;
  final String deviceName;
  final String devicePrice;
  final String deviceRent;
  final String deviceDescription;
  final String deviceQuantity;
  final String deviceInstruction;
  final String deviceImage1;
  final String deviceImage2;
  final String deviceImage3;
  final String deviceId;

  const MyDeviceDetails({
    super.key,
    required this.deviceName,
    required this.devicePrice,
    required this.deviceRent,
    required this.deviceDescription,
    required this.deviceQuantity,
    required this.deviceInstruction,
    required this.deviceImage1,
    required this.deviceImage2,
    required this.deviceImage3,
    required this.supplierEmail,
    required this.deviceId,
  });

  @override
  State<MyDeviceDetails> createState() => _MyDeviceDetailsState();
}

class _MyDeviceDetailsState extends State<MyDeviceDetails> {
  TextEditingController deviceName = TextEditingController();
  TextEditingController devicePriceForPuy = TextEditingController();
  TextEditingController devicePriceForRent = TextEditingController();
  TextEditingController deviceDescription = TextEditingController();
  TextEditingController deviceQuantity = TextEditingController();
  TextEditingController deviceInstructions = TextEditingController();
  Uint8List? _device1;
  Uint8List? _device2;
  Uint8List? _device3;
  String? imageDevice1;
  String? imageDevice2;
  String? imageDevice3;

  @override
  void initState() {
    fetchDeviceData();
    super.initState();
  }

  void fetchDeviceData() async {
    try {
      var supplierDoc = await FirebaseFirestore.instance
          .collection('Devices')
          .where('DeviseId', isEqualTo: widget.deviceId)
          .get();

      if (supplierDoc.docs.isNotEmpty) {
        var deviceData = supplierDoc.docs[0].data();

        setState(() {
          deviceName.text = deviceData['Device_Name'] ?? "";
          devicePriceForPuy.text = deviceData['devicePriceForPuy'] ?? "";
          devicePriceForRent.text = deviceData['devicePriceForRent'] ?? "";
          deviceDescription.text = deviceData['deviceDescription'] ?? "";
          deviceQuantity.text = deviceData['deviceQuantity'] ?? "";
          deviceInstructions.text = deviceData['deviceInstructions'] ?? "";
          imageDevice1 = deviceData['DeviceImages_1'] ??
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP9WxCuO9kRKoQ2G8C3DuO6DU7CjdL_urDMSMtR19lUQ&s";
          imageDevice2 = deviceData['DeviceImages_2'] ??
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP9WxCuO9kRKoQ2G8C3DuO6DU7CjdL_urDMSMtR19lUQ&s";
          imageDevice3 = deviceData['DeviceImages_3'] ??
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP9WxCuO9kRKoQ2G8C3DuO6DU7CjdL_urDMSMtR19lUQ&s";
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

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

  void firstImageDevice() async {
    StoreImg().saveProfileSupplierImg(
        file: _device2!,
        supplierEmail: widget.supplierEmail,
        storagePath: 'DeviceImage1',
        firestoreCollectionName: 'Devices',
        supplierFireStoreFiledName: 'DeviceImages_2');
  }

  void secondImageDevice() async {
    StoreImg().saveProfileSupplierImg(
        file: _device3!,
        supplierEmail: widget.supplierEmail,
        storagePath: 'DeviceImage2',
        firestoreCollectionName: 'Devices',
        supplierFireStoreFiledName: 'DeviceImages_3');
  }

  void thirdImageDevice() async {
    StoreImg().saveProfileSupplierImg(
        file: _device1!,
        supplierEmail: widget.supplierEmail,
        storagePath: 'DeviceImage3',
        firestoreCollectionName: 'Devices',
        supplierFireStoreFiledName: 'DeviceImages_1');
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
                          : imageDevice1 != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(imageDevice1!),
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
                          : imageDevice2 != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(imageDevice2!),
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
                          : imageDevice3 != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(imageDevice3!),
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
              updateDeviceData();
              firstImageDevice();
              secondImageDevice();
              thirdImageDevice();
              // Navigator.of(context).pop();
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
        'deviceQuantity': deviceQuantity.text,
        'deviceInstructions': deviceInstructions.text,
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
