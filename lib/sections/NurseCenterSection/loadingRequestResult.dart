import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RequestResult extends StatefulWidget {
  final int status;
  final String formRequestId;
  const RequestResult({
    super.key,
    required this.status,
    required this.formRequestId,
  });

  @override
  State<RequestResult> createState() => _RequestResultState();
}

class _RequestResultState extends State<RequestResult> {
  late Stream<DocumentSnapshot> _documentStream;

  @override
  void initState() {
    super.initState();
    _documentStream = FirebaseFirestore.instance
        .collection('form_request')
        .doc(widget.formRequestId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF1C8892),
            centerTitle: true,
            title: Text(
              'Request Result',
              style: TextStyle(color: Colors.white),
            ),
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
                // A child widget
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
                      final status = data['status'] as int?;
                      if (status == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                'images/Animation - 1714757310336.json',
                                width: 200),
                            Text(
                              "please wait while center\n accept or reject your request"
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
                            Text(
                              "accept request".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
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
                              'your request has been rejected please check another centers to help you'
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
