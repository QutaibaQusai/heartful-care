import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/resources/add_img.dart';
import 'package:test/utils.dart';

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
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveSupplierProfile() async {
    StoreImg().saveProfileSupplierImg(file: _image!);
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
                                        setState(() {
                                          isEditable = !isEditable;
                                        });
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.ellipsisVertical,
                                        color: Colors.black,
                                        size: 24,
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
                            _image != null
                                ? Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF1C8892),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 64,
                                          backgroundImage: MemoryImage(_image!),
                                        )),
                                  )
                                : Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF1C8892),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png',
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                            Positioned(
                              bottom: 1,
                              left: 120,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                ),
                              ),
                            )
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
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.user,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier name',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierPhoneNumber,
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.mobile,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier phone number',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierEmail,
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.envelope,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier email',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierWebsite,
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.globe,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier website',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierLocation,
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.locationArrow,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier Location',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: supplierDescription,
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
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
                      enabled: isEditable,
                      autofocus: false,
                      decoration: InputDecoration(
                        disabledBorder: isEditable ? null : InputBorder.none,
                        focusedBorder: isEditable
                            ? UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )
                            : InputBorder.none,
                        prefixIcon: Icon(FontAwesomeIcons.solidCreditCard,
                            color: Color(0xFF1C8892)),
                        hintText: 'Supplier payment options',
                      ),
                    ),
                    SizedBox(height: 15),
                    //Text("ss" + widget.supplierEmail)
                  ],
                ),
              )
            ],
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
            onPressed: isEditable
                ? () {
                    _submitUserData();
                    saveSupplierProfile();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Save",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitUserData() async {
    try {
      CollectionReference centers =
          FirebaseFirestore.instance.collection('Suppliers');

      // Find the user document
      var querySnapshot =
          await centers.where("Email", isEqualTo: widget.supplierEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];
        var userId = documentSnapshot.id;

        // Add new fields to the existing document
        await centers.doc(userId).set({
          'supplier_Name': supplierName.text,
          'supplier_email': supplierEmail.text,
          'supplier_phoneNumber': supplierPhoneNumber.text,
          'supplier_location': supplierLocation.text,
          'supplier_website': supplierWebsite.text,
          'supplier_description': supplierDescription.text,
          'supplier_paymnet_option': supplierPaymentOption.text,
          // 'urlProfileLink': saveSupplierProfile.,
        }, SetOptions(merge: true));

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
