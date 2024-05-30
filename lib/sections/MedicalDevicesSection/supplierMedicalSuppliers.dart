import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test/model/medicalDevicesSupplierModel.dart';
import 'package:test/sections/MedicalDevicesSection/supplerDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierMedicalSupplier extends StatefulWidget {
  final String userEmail;
  const SupplierMedicalSupplier({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<SupplierMedicalSupplier> createState() => _MedicalState();
}

class _MedicalState extends State<SupplierMedicalSupplier> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Suppliers",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF1C8892),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Suppliers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<MedicalSupplier> medicalSupplier = snapshot.data!.docs
                .map((doc) =>
                    MedicalSupplier.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: medicalSupplier.length,
              itemBuilder: (context, index) {
                var supplier = medicalSupplier[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SupplierDetails(
                              name: supplier.name,
                              phoneNumber: supplier.phoneNumber,
                              emailAddress: supplier.emailAddress,
                              website: supplier.website,
                              location: supplier.location,
                              description: supplier.description,
                              paymentOption: supplier.paymentOption,
                              logoImage: supplier.logoImage,
                              userEmail: widget.userEmail,
                              supplierCover: supplier.supplierCover,
                              supplierId: snapshot.data!.docs[index].id,
                            ),
                            type: PageTransitionType.fade));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Color(0xFFD1E7E9),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 6,
                                child: Image.network(
                                  supplier.supplierCover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      supplier.name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Text("4.7")
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      _makePhoneCall(supplier.phoneNumber);
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      color: Color(0xFF1C8892),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Image.network(
                                  supplier.logoImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    String telScheme = 'tel:$phoneNumber';
    try {
      if (await canLaunch(telScheme)) {
        await launch(telScheme);
      } else {
        throw 'Could not launch $telScheme';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }
}
