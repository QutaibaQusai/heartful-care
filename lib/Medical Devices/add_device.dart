import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Add_device extends StatefulWidget {
  final String supplierEmail;

  const Add_device({super.key, required this.supplierEmail});

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
                Text(
                  "Device Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                buildTextFormField(deviceName, "Device Name"),
                buildTextFormField(devicePriceForPuy, "Device Price"),
                buildTextFormField(
                    devicePriceForRent, "Device Price for rent per month"),
                buildTextFormField(deviceDescription, "Description"),
                buildTextFormField(deviceQuantity, "Device quantity"),
                buildTextFormField(
                    deviceInstructions, "Instructions about device"),
                //Text(widget.supplierEmail)
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
      CollectionReference suppliers =
          FirebaseFirestore.instance.collection('Suppliers');

      // Find the user document
      var querySnapshot =
          await suppliers.where("Email", isEqualTo: widget.supplierEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];
        var supplierId = documentSnapshot.id;

        // Reference to the devices sub-collection
        CollectionReference devices =
            suppliers.doc(supplierId).collection('Devices');

        // Add new fields to the existing document in devices sub-collection
        await devices.add({
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
              'User data updated successfully!',
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
              'User not found',
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
            'Error updating user data: $e',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }
}
