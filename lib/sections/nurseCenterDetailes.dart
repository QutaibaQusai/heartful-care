import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNurseCenter extends StatefulWidget {
  final String centerName;
  final String operatingHours;
  final String centerPhoneNumber;
  DetailedNurseCenter(
      {required this.centerName,
      required this.operatingHours,
      required this.centerPhoneNumber});

  @override
  State<DetailedNurseCenter> createState() => _DetailedNurseCenter();
}

class _DetailedNurseCenter extends State<DetailedNurseCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // Placeholder for network image
                color: Colors.grey,
                child: Image.network(
                  'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  height: 170,
                ),
              ),
            ),
            SizedBox(width: 16), // Add spacing between image and text
            Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.centerName,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C8892)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.operatingHours,
                      style: TextStyle(fontSize: 16, color: Color(0xFF1C8892)),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                _makePhoneCall(widget.centerPhoneNumber);
                              },
                              icon: Icon(Icons.call, color: Color(0xFF1C8892)),
                            ),
                            Text(
                              'Call',
                              style: TextStyle(color: Color(0xFF1C8892)),
                            ),
                          ],
                        ),
                        SizedBox(width: 24),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle chat action
                              },
                              icon: Icon(Icons.chat, color: Color(0xFF1C8892)),
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(color: Color(0xFF1C8892)),
                            ),
                          ],
                        ),
                        SizedBox(width: 24),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle reviews action
                              },
                              icon: Icon(Icons.star, color: Color(0xFF1C8892)),
                            ),
                            Text(
                              'Reviews',
                              style: TextStyle(color: Color(0xFF1C8892)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    String telScheme = 'tel:$phoneNumber';
    try {
      if (await canLaunch(telScheme)) {
        await launch(telScheme);
      } else {
        throw 'Could not launch $telScheme';
      }
    } catch (e) {
      print('Error launching phone call: $e');
      // Handle the error here, such as showing an error dialog
    }
  }
}
