import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Medical%20Devices/supplier_edit_my_device.dart';
import 'package:test/model/devicesModel.dart';

class SupplierMyDevices extends StatefulWidget {
  final String supplierEmail;

  const SupplierMyDevices({Key? key, required this.supplierEmail})
      : super(key: key);

  @override
  State<SupplierMyDevices> createState() => _MyDevicesState();
}

class _MyDevicesState extends State<SupplierMyDevices> {
  late String _supplierId;
  late Stream<List<Devices>> _devicesStream;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final supplier = FirebaseAuth.instance.currentUser;
    if (supplier != null) {
      _supplierId = supplier.uid;
      _devicesStream = FirebaseFirestore.instance
          .collection("Devices")
          .where("supplierId", isEqualTo: _supplierId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Devices.fromMap(doc.id, doc.data()))
              .toList());
    } else {
      _supplierId = '';
      _devicesStream = Stream.value([]);
    }
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
            "My Devices",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<void>(
          future: _initializeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || _supplierId.isEmpty) {
              return Center(
                  child: Text("Error fetching supplier ID or not found"));
            } else {
              return StreamBuilder<List<Devices>>(
                stream: _devicesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No devices found"));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final device = snapshot.data![index];
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                deleteDevice(context, device.deviceId);
                              },
                              backgroundColor: Color(0xFF1C8892),
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SupplierEditMyDevice(
                                        deviceName: device.deviceName,
                                        devicePrice: device.deviceBuyPrice,
                                        deviceRent: device.deviceRentPrice,
                                        deviceDescription:
                                            device.deviceDescription,
                                        //
                                        deviceInstruction:
                                            device.deviceInstruction,
                                        //
                                        supplierEmail: widget.supplierEmail,
                                        deviceId: device.deviceId,
                                        deviceImage1: device.deviceImages[0],
                                        deviceImage2: device.deviceImages[1],
                                        deviceImage3: device.deviceImages[2],
                                        deviceAavailability:
                                            device.deviceAavailability,
                                      );
                                    },
                                  ),
                                );
                              },
                              backgroundColor: Color(0xFF1C8892),
                              icon: Icons.edit,
                            ),
                          ],
                        ),
                        child: Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              7,
                            ), // Adjust border radius as needed
                            side: BorderSide(
                              color: Colors.grey,
                            ), // Border color
                          ),
                          color: Colors.white, // Background color of the card

                          child: Padding(
                            padding: EdgeInsets.all(16),

                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 7,
                              child: Row(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.network(
                                        device.deviceImages[0],
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            device.deviceName,
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // Divider(),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Method to delete a device from Firestore
  Future<void> deleteDevice(BuildContext context, String deviceId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Devices")
          .doc(deviceId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Device deleted successfully',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to delete device: $error",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }
}
