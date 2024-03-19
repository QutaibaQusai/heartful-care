import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/utils/storeImg%20.dart';
import 'package:test/utils/pickImage.dart';

class EditSupplierProfile extends StatefulWidget {
  final String supplierEmail;

  const EditSupplierProfile({super.key, required this.supplierEmail});

  @override
  State<EditSupplierProfile> createState() => _EditSupplierProfileState();
}

class _EditSupplierProfileState extends State<EditSupplierProfile> {
  TextEditingController supplierName = TextEditingController();
  TextEditingController supplierPhoneNumber = TextEditingController();
  TextEditingController supplierWebsite = TextEditingController();
  TextEditingController supplierLocation = TextEditingController();
  TextEditingController supplierDescription = TextEditingController();
  TextEditingController supplierPaymentOption = TextEditingController();
  Uint8List? _profileImage;
  Uint8List? coverImage;
  String? _imageProfileUrl;
  String? imageCoverUrl;

  bool editSupplierCover = false;
  bool editSupplierLogo = false;
  bool editSupplierInfo = false;
  bool isEditable = false;

  void selectProfileImageSupplier() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = img;
    });
  }

  void selectCoverImageSupplier() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      coverImage = img;
    });
  }

  void saveProfileImageSupplier() async {
    StoreImg().saveProfileSupplierImg(
        file: _profileImage!,
        supplierEmail: widget.supplierEmail,
        storagePath: 'profileSupplierImg',
        firestoreCollectionName: 'Suppliers',
        supplierFireStoreFiledName: 'supplier_profile');
  }

  void saveCoverImageSupplier() async {
    StoreImg().saveProfileSupplierImg(
        file: coverImage!,
        supplierEmail: widget.supplierEmail,
        storagePath: 'coverSupplierImg',
        firestoreCollectionName: 'Suppliers',
        supplierFireStoreFiledName: 'supplier_cover');
  }

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
          // supplierEmail.text = userData['supplier_email'] ?? "";
          supplierWebsite.text = userData['supplier_website'] ?? "";
          supplierLocation.text = userData['supplier_location'] ?? "";
          supplierDescription.text = userData['supplier_description'] ?? "";
          supplierPaymentOption.text =
              userData['supplier_paymnet_option'] ?? "";
          _imageProfileUrl = userData['supplier_profile'];
          imageCoverUrl = userData['supplier_cover'];
        });
      }
    } catch (e) {
      print('Error fetching user data:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Edit Profile"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Supplier Logo",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              editSupplierLogo = !editSupplierLogo;
                            });
                          },
                          icon: Text(
                            "Edit",
                            style: TextStyle(
                                color: Color(0xFF1C8892), fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Color(0xFF1C8892),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _profileImage != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage:
                                        MemoryImage(_profileImage!),
                                  )
                                : _imageProfileUrl != null
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage:
                                            NetworkImage(_imageProfileUrl!),
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
                        Positioned(
                          bottom: 10,
                          left: 120,
                          child: editSupplierLogo
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xFF1C8892),
                                  child: IconButton(
                                    onPressed: selectProfileImageSupplier,
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Supplier Cover",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              editSupplierCover = !editSupplierCover;
                            });
                          },
                          icon: Text(
                            "Edit",
                            style: TextStyle(
                                color: Color(0xFF1C8892), fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 5,
                          child: coverImage != null
                              ? Image.memory(
                                  coverImage!,
                                  fit: BoxFit.cover,
                                )
                              : imageCoverUrl != null
                                  ? Image.network(
                                      imageCoverUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      "https://media.istockphoto.com/id/1447388979/vector/modern-blue-medical-technology-background-vector-polygon-pattern.jpg?s=612x612&w=0&k=20&c=GsfF2ldGnhFvhcMoRrsSgbhQAy8Bdy9h4QPMSeZFsoo=",
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: editSupplierCover
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xFF1C8892),
                                  child: IconButton(
                                    onPressed: () {
                                      selectCoverImageSupplier();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Supplier Info",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isEditable = !isEditable;
                            });
                          },
                          icon: Text(
                            "Edit",
                            style: TextStyle(
                                color: Color(0xFF1C8892), fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: supplierName,
                    enabled: isEditable,
                    autofocus: false,
                    decoration: InputDecoration(
                      disabledBorder: isEditable ? null : InputBorder.none,
                      focusedBorder: isEditable
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
                            )
                          : InputBorder.none,
                      prefixIcon:
                          Icon(FontAwesomeIcons.user, color: Color(0xFF1C8892)),
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
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
                            )
                          : InputBorder.none,
                      prefixIcon: Icon(FontAwesomeIcons.mobile,
                          color: Color(0xFF1C8892)),
                      hintText: 'Supplier phone number',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: widget.supplierEmail,
                    enabled: false,
                    autofocus: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      disabledBorder: isEditable ? null : InputBorder.none,
                      focusedBorder: isEditable
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
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
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
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
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
                            )
                          : InputBorder.none,
                      prefixIcon: Icon(FontAwesomeIcons.locationArrow,
                          color: Color(0xFF1C8892)),
                      hintText: 'Supplier Location',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    maxLines: 2,
                    minLines: 1,
                    controller: supplierDescription,
                    enabled: isEditable,
                    autofocus: false,
                    decoration: InputDecoration(
                      disabledBorder: isEditable ? null : InputBorder.none,
                      focusedBorder: isEditable
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
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
                              borderSide: BorderSide(color: Color(0xFF1C8892)),
                            )
                          : InputBorder.none,
                      prefixIcon: Icon(FontAwesomeIcons.solidCreditCard,
                          color: Color(0xFF1C8892)),
                      hintText: 'Supplier payment options',
                    ),
                  ),
                ],
              ),
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
            saveProfileImageSupplier();
            saveCoverImageSupplier();
          },
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
    );
  }

  Future<void> _submitUserData() async {
    try {
      CollectionReference centers =
          FirebaseFirestore.instance.collection('Suppliers');

      var querySnapshot =
          await centers.where("Email", isEqualTo: widget.supplierEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];
        var userId = documentSnapshot.id;

        await centers.doc(userId).set({
          'supplier_Name': supplierName.text,
          'supplier_phoneNumber': supplierPhoneNumber.text,
          'supplier_location': supplierLocation.text,
          'supplier_website': supplierWebsite.text,
          'supplier_description': supplierDescription.text,
          'supplier_paymnet_option': supplierPaymentOption.text,
          'supplier_email': widget.supplierEmail,
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
        Navigator.pop(
            context, true); // Pop with a result of 'true' to indicate success
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
