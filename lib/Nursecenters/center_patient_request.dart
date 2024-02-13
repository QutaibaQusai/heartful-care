import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientRequest extends StatefulWidget {
  const PatientRequest({super.key});

  @override
  State<PatientRequest> createState() => _PatientRequestState();
}

class _PatientRequestState extends State<PatientRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Patient request"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF1C8892) // Set the border color
                    ,
                    width: 2.0, // Set the border width
                  ),
                ),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height / 8,
                // color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Qutaiba Qusai Makahleh",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              backgroundColor: Color(0xFF1C8892),
                              child: Icon(FontAwesomeIcons.check),
                            ),
                          ),
                          IconButton(
                            icon: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(FontAwesomeIcons.xmark)),
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
