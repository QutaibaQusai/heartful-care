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
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Consumer<MyProvider>(
          builder: (context, value, child) => Text(
            "${value.items![widget.index].deviceName} Instractions",
            style: TextStyle(color: Colors.white),
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
          ),
        ),
      ),
      body: Consumer<MyProvider>(
          builder: (context, value, child) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                  // Text(value.items![widget.index].deviceInstruction)
                ],
              )),
    ));
  }
}
