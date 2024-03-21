import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool isEditable = false;

  void selectProfileImageSupplier(
      {required ImageSource galleryOrCamera}) async {
    Uint8List img = await pickImage(galleryOrCamera);
    setState(() {
      _profileImage = img;
    });
  }

  void selectCoverImageSupplier({required ImageSource galleryOrCamera}) async {
    Uint8List img = await pickImage(galleryOrCamera);
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
                            showImageSelectionBottomSheet(isProfileImage: true);
                            // setState(() {
                            //   editSupplierLogo = !editSupplierLogo;
                            // });
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
                            showImageSelectionBottomSheet(
                                isProfileImage: false);
                            // setState(() {
                            //   editSupplierCover = !editSupplierCover;
                            // });
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
                  buildCustomTextFormField(
                    controller: supplierName,
                    enabled: isEditable,
                    icon: FontAwesomeIcons.user,
                    hintText: 'Supplier name',
                  ),
                  buildCustomTextFormField(
                    controller: supplierPhoneNumber,
                    enabled: isEditable,
                    icon: FontAwesomeIcons.mobile,
                    hintText: 'Supplier phone number',
                  ),
                  buildCustomTextFormField(
                    initialValue: widget.supplierEmail,
                    enabled: false,
                    readOnly: true,
                    icon: FontAwesomeIcons.envelope,
                    hintText: 'Supplier email',
                  ),
                  buildCustomTextFormField(
                    controller: supplierWebsite,
                    enabled: isEditable,
                    icon: FontAwesomeIcons.globe,
                    hintText: 'Supplier website',
                  ),
                  buildCustomTextFormField(
                    controller: supplierLocation,
                    enabled: isEditable,
                    icon: FontAwesomeIcons.locationArrow,
                    hintText: 'Supplier Location',
                  ),
                  buildCustomTextFormField(
                    controller: supplierDescription,
                    enabled: isEditable,
                    icon: FontAwesomeIcons.info,
                    hintText: 'Supplier description',
                    maxLines: 2,
                  ),
                  buildCustomTextFormField(
                    controller: supplierPaymentOption,
                    enabled: isEditable,
                    icon: FontAwesomeIcons.solidCreditCard,
                    hintText: 'Supplier payment options',
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
      CollectionReference suppliers =
          FirebaseFirestore.instance.collection('Suppliers');

      var querySnapshot =
          await suppliers.where("Email", isEqualTo: widget.supplierEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];
        var supplierId = documentSnapshot.id; // Retrieve the document ID

        await suppliers.doc(supplierId).set({
          'supplier_Name': supplierName.text,
          'supplier_phoneNumber': supplierPhoneNumber.text,
          'supplier_location': supplierLocation.text,
          'supplier_website': supplierWebsite.text,
          'supplier_description': supplierDescription.text,
          'supplier_paymnet_option': supplierPaymentOption.text,
          'supplier_email': widget.supplierEmail,
          'supplier_id': supplierId, // Save the document ID in the document
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'User data updated successfully!',
              style: TextStyle(fontSize: 17),
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
            'Error updating user data: $e',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }

  void showImageSelectionBottomSheet({required bool isProfileImage}) {
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
                    Navigator.pop(context); // Close the bottom sheet
                    if (isProfileImage) {
                      selectProfileImageSupplier(
                          galleryOrCamera: ImageSource.gallery);
                    } else {
                      selectCoverImageSupplier(
                          galleryOrCamera: ImageSource.gallery);
                    }
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
                    Navigator.pop(context); // Close the bottom sheet
                    if (isProfileImage) {
                      selectProfileImageSupplier(
                          galleryOrCamera: ImageSource.camera);
                    } else {
                      selectCoverImageSupplier(
                          galleryOrCamera: ImageSource.camera);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCustomTextFormField({
    TextEditingController? controller,
    String? initialValue,
    bool enabled = true,
    IconData? icon,
    String hintText = '',
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        enabled: enabled && !readOnly,
        autofocus: false,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          disabledBorder: enabled ? null : InputBorder.none,
          focusedBorder: enabled
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1C8892)),
                )
              : InputBorder.none,
          prefixIcon:
              icon != null ? Icon(icon, color: Color(0xFF1C8892)) : null,
          hintText: hintText,
        ),
      ),
    );
  }
}
