import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/Medical%20Devices/supplier_settings.dart';

class Suppliers_Home extends StatelessWidget {
  const Suppliers_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Suppliers_sittings()));
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
