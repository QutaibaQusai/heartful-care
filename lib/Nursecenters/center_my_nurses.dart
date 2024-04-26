import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CenterMyNurses extends StatefulWidget {
  final String centerId;
  const CenterMyNurses({super.key, required this.centerId});

  @override
  State<CenterMyNurses> createState() => _CenterMyNursesState();
}

class _CenterMyNursesState extends State<CenterMyNurses> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Nurses List",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
// body: ,
      ),
    );
  }
}
