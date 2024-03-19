import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
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
          _imageUrl = userData['supplier_profile'];
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
        backgroundColor: Color(0xFFD1E7E9),
        appBar: AppBar(
          backgroundColor: Color(0xFFD1E7E9),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Orders \nDevice",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    "images/supplierHomePage.svg",
                    width: MediaQuery.of(context).size.width / 3,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                            color: Color(0xFF1C8892),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "New order request received. We've got it from here!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  "Number of orders: 18",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 216, 210, 210),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Last Orders",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 9,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: double.infinity,
                                  child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTvEkQUIq0n3AMgcKON0e2SkFvd1P4PIWoJz3GNN1Qul41UFBY1j7fweQJut4OM38Cu1o&usqp=CAU"),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Qutaiba Qusai Makahleh",
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
