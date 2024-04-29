import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Request Result'),
      ),
      body: Center(
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
                    Lottie.asset('images/Animation - 1714324335561.json',
                        width: 150),
                    Text(
                        "please wait while center accept or reject your request")
                  ],
                );
              } else if (status == 1) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("accept request"),
                    // Text('Form Request ID: ${widget.formRequestId}')
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("images/Animation - 1714324734362.json"),
                    Text(
                        'your request has been rejected please choose another center to help you :)'),
                    // Text('Form Request ID: ${widget.formRequestId}')
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
