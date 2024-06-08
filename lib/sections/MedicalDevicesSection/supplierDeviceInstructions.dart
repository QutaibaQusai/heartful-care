import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';

class SupplierDeviceInstruction extends StatefulWidget {
  final int index;
  const SupplierDeviceInstruction({super.key, required this.index});

  @override
  State<SupplierDeviceInstruction> createState() =>
      _SupplierDeviceInstructionState();
}

class _SupplierDeviceInstructionState extends State<SupplierDeviceInstruction> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Consumer<MyProvider>(
            builder: (context, value, child) => Text(
              "Instructions",
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1C8892),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
              size: width * 0.05,
            ),
          ),
        ),
        body: Consumer<MyProvider>(
          builder: (context, value, child) => Column(
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Text(
                  value.items![widget.index].deviceInstruction,
                  style: TextStyle(fontSize: width * 0.045),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
