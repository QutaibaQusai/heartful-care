import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SupplierLoadingPage extends StatefulWidget {
  final int status;
  final String orderId;
  const SupplierLoadingPage(
      {super.key, required this.status, required this.orderId});

  @override
  State<SupplierLoadingPage> createState() => _LoadingState();
}

class _LoadingState extends State<SupplierLoadingPage> {
  late Stream<DocumentSnapshot> _documentStream;

  @override
  void initState() {
    super.initState();
    _documentStream = FirebaseFirestore.instance
        .collection('Device_order')
        .doc(widget.orderId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              ColorfulBackground(
                duration: Duration(milliseconds: 1000),
                backgroundColors: [
                  const Color(0xFF1C8892),
                  const Color.fromARGB(255, 255, 255, 255),
                  const Color.fromARGB(255, 255, 255, 255),
                  const Color(0xFF1C8892),
                  const Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              Center(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _documentStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('Document not found');
                    } else {
                      final data = snapshot.data!;
                      final status = data['orderStatus'] as int?;
                      if (status == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                'images/Animation - 1714757310336.json',
                                width: 200),
                            Text(
                              "please wait while supplier\n accept or reject your request"
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      } else if (status == 1) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                                "Your request has been" +
                                    " accepted ".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                "images/Animation - 1714758913080.json",
                                width: 180),
                            Text(
                              'your request has been rejected please check another supplier to help you'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
