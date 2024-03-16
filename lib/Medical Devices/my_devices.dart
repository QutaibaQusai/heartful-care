import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/model/devicesModel.dart';

class MyDevices extends StatefulWidget {
  final String supplierEmail;

  const MyDevices({Key? key, required this.supplierEmail}) : super(key: key);

  @override
  State<MyDevices> createState() => _MyDevicesState();
}

class _MyDevicesState extends State<MyDevices> {
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
          .map((snapshot) =>
              snapshot.docs.map((doc) => Devices.fromMap(doc.data())).toList());
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
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 6,
                                child: Row(
                                  children: [
                                    Container(
                                      height: double.infinity,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(13),
                                        child: Image.network(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTvEkQUIq0n3AMgcKON0e2SkFvd1P4PIWoJz3GNN1Qul41UFBY1j7fweQJut4OM38Cu1o&usqp=CAU",
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
                                            Text(
                                              device.deviceDescription,
                                              overflow: TextOverflow.clip,
                                              maxLines: 4,
                                            ),
                                            Expanded(child: Container()),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Text(
                                                      device.devicePrice,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text("Rent pre week " +
                                                      device.deviceRent +
                                                      "JD"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                            ],
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
}
