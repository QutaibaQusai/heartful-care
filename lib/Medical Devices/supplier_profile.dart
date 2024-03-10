import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Medical%20Devices/editSupplierProfile.dart';

class Supplier_profile extends StatefulWidget {
  final String supplierEmail;

  const Supplier_profile({Key? key, required this.supplierEmail})
      : super(key: key);

  @override
  State<Supplier_profile> createState() => _Supplier_profileState();
}

class _Supplier_profileState extends State<Supplier_profile> {
  TextEditingController supplierName = TextEditingController();
  TextEditingController supplierPhoneNumber = TextEditingController();
  TextEditingController supplierEmail = TextEditingController();
  TextEditingController supplierWebsite = TextEditingController();
  TextEditingController supplierLocation = TextEditingController();
  TextEditingController supplierDescription = TextEditingController();
  TextEditingController supplierPaymentOption = TextEditingController();
  String? _imageUrl;

  bool isEditable = false;

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  void fetchUserData() async {
    try {
      var supplierDoc = await FirebaseFirestore.instance
          .collection('Suppliers')
          .where('Email', isEqualTo: widget.supplierEmail)
          .get();

      if (supplierDoc.docs.isNotEmpty) {
        var userData = supplierDoc.docs[0].data();

        setState(() {
          supplierName.text = userData['supplier_Name'] ?? "";
          supplierPhoneNumber.text = userData['supplier_phoneNumber'] ?? "";
          supplierEmail.text = userData['supplier_email'] ?? "";
          supplierWebsite.text = userData['supplier_website'] ?? "";
          supplierLocation.text = userData['supplier_location'] ?? "";
          supplierDescription.text = userData['supplier_description'] ?? "";
          supplierPaymentOption.text =
              userData['supplier_paymnet_option'] ?? "";
          _imageUrl = userData['imageLink'];
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          "https://www.healthcarefacilitiestoday.com/media/graphics/2018/18034-operating-room.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        child: ClipRRect(
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaY: 2, sigmaX: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.angleLeft,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      "Supplier profile",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditSupplierProfile(
                                              supplierEmail:
                                                  widget.supplierEmail,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.pen,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Stack(
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Color(0xFF1C8892),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _imageUrl != null
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage:
                                            NetworkImage(_imageUrl!),
                                      )
                                    : ClipOval(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(48),
                                          child: Image.network(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: supplierName,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.user,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier name',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierPhoneNumber,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.mobile,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier phone number',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierEmail,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.envelope,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier email',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierWebsite,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.globe,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier website',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierLocation,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.locationArrow,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier Location',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierDescription,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.info,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier description',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierPaymentOption,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.solidCreditCard,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier payment options',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
