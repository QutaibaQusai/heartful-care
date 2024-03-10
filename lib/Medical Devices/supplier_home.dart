import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/Medical%20Devices/supplier_settings.dart';

class SuppliersHome extends StatefulWidget {
  final String supplierEmail;

  const SuppliersHome({Key? key, required this.supplierEmail})
      : super(key: key);

  @override
  State<SuppliersHome> createState() => _SuppliersHomeState();
}

class _SuppliersHomeState extends State<SuppliersHome> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    fetchSupplierData();
  }

  void fetchSupplierData() async {
    try {
      var supplierDoc = await FirebaseFirestore.instance
          .collection('Suppliers')
          .where('Email', isEqualTo: widget.supplierEmail)
          .get();

      if (supplierDoc.docs.isNotEmpty) {
        var userData = supplierDoc.docs[0].data();

        setState(() {
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
        appBar: AppBar(
          title: Text("Orders"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Suppliers_sittings(
                      supplierEmail: widget.supplierEmail,
                    ),
                  ),
                );
              },
              icon: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: _imageUrl != null
                    ? CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(_imageUrl!),
                        backgroundColor: Colors.white,
                      )
                    : CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png'),
                        backgroundColor: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
