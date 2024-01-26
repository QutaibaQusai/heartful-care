import 'package:flutter/material.dart';
import 'package:test/Settings/addaddresspage.dart';

class YourSavedAddress extends StatefulWidget {
  final String userEmail;

  const YourSavedAddress({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<YourSavedAddress> createState() => _YourSavedAddressState();
}

class _YourSavedAddressState extends State<YourSavedAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Addresses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: true, // Center the title horizontally
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddAddressPage(userEmail: widget.userEmail),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
