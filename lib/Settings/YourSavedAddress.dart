import 'package:flutter/material.dart';

class YourSavedAddress extends StatefulWidget {
  const YourSavedAddress({Key? key}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}