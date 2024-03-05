import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/Medical%20Devices/supplier_settings.dart';

class Suppliers_Home extends StatelessWidget {
  final String supplierEmail;
  const Suppliers_Home({super.key, required this.supplierEmail});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Orders"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Suppliers_sittings(
                          supplierEmail: supplierEmail,
                        )));
              },
              icon: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('images/logo2.png'),
                  backgroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Text(supplierEmail),
        ),
      ),
    );
  }
}
