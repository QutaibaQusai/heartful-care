import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
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
  // TextEditingController supplierEmail = TextEditingController();
  TextEditingController supplierWebsite = TextEditingController();
  TextEditingController supplierLocation = TextEditingController();
  TextEditingController supplierDescription = TextEditingController();
  TextEditingController supplierPaymentOption = TextEditingController();
  String? _supplierProfile;
  String? _supplierCover;

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
          supplierWebsite.text = userData['supplier_website'] ?? "";
          supplierLocation.text = userData['supplier_location'] ?? "";
          supplierDescription.text = userData['supplier_description'] ?? "";
          supplierPaymentOption.text =
              userData['supplier_paymnet_option'] ?? "";
          _supplierProfile = userData['supplier_profile'];
          _supplierCover = userData['supplier_cover'];
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
                          child: _supplierCover != null
                              ? Image.network(
                                  _supplierCover!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://www.healthcarefacilitiestoday.com/media/graphics/2018/18034-operating-room.jpg",
                                  fit: BoxFit.cover,
                                )),
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
                                      onPressed:
                                          navigateAndUpdateProfile, // Update this line
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
                                child: _supplierProfile != null
                                    ? InstaImageViewer(
                                        child: CircleAvatar(
                                          radius: 64,
                                          backgroundImage:
                                              NetworkImage(_supplierProfile!),
                                        ),
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
                      initialValue: widget.supplierEmail,
                      // controller: supplierEmail,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          FontAwesomeIcons.envelope,
                          color: Color(0xFF1C8892),
                        ),
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
                        prefixIcon: Icon(
                          FontAwesomeIcons.globe,
                          color: Color(0xFF1C8892),
                        ),
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
                      maxLines:
                          null, // Setting maxLines to null to allow multiline input
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          FontAwesomeIcons.info,
                          color: Color(0xFF1C8892),
                        ),
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

  Future<void> navigateAndUpdateProfile() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EditSupplierProfile(supplierEmail: widget.supplierEmail),
      ),
    );

    if (result == true) {
      fetchUserData();
    }
  }
}
