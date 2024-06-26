import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/Medical%20Devices/supplierOrderDetails.dart';
import 'package:test/provider/myprovider.dart';
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
  String? supplierId;

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
          supplierId = userData['supplier_id'];
        });

        // Fetch orders after supplier ID is set
        if (supplierId != null) {
          context.read<MyProvider>().getOrder(supplier_id: supplierId!);
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
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
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Color(0xFF1C8892),
          onRefresh: () async {
            fetchSupplierData();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    child: Stack(
                      children: [
                        Text(
                          "Your Orders \nDevice",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: SvgPicture.asset(
                            "images/supplierHomePage.svg",
                            width: MediaQuery.of(context).size.width / 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 5,
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
                                    "New order request received. We've got it from here!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Consumer<MyProvider>(
                                    builder: (context, provider, child) {
                                      return Text(
                                        "Number of orders: ${provider.orders?.length ?? 0}",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 216, 210, 210),
                                        ),
                                      );
                                    },
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
                        Consumer<MyProvider>(
                          builder: (context, value, child) {
                            if (value.orders == null) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Color(0xFF1C8892),
                              ));
                            }
                            if (value.orders!.isEmpty) {
                              return Center(child: Text("No Orders yet"));
                            }
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.orders!.length,
                              itemBuilder: (context, index) {
                                final order = value.orders![index];
                                if (order.orderStatus != 0) {
                                  return SizedBox.shrink();
                                }
                                return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFD1E7E9),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF1C8892),
                                                      shape: BoxShape.circle),
                                                  child: ClipOval(
                                                    child: SizedBox.fromSize(
                                                      size: Size.fromRadius(
                                                          48), // Image radius
                                                      child: order.userImage
                                                              .isNotEmpty
                                                          ? Image.network(
                                                              order.userImage,
                                                              fit: BoxFit.cover)
                                                          : Image.network(
                                                              "https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png",
                                                              fit:
                                                                  BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${order.userName.toUpperCase()}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(order
                                                      .userOrderTimeAndDate
                                                      .toDate()
                                                      .toString())
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child:
                                            SupplierOrderDetails(index: index),
                                        type: PageTransitionType.fade,
                                      ),
                                    );
                                    print(order.orderStatus);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
