// AllDevicesPage.dart
import 'package:flutter/material.dart';

class AllDevicesPage extends StatefulWidget {
  const AllDevicesPage({Key? key}) : super(key: key);

  @override
  State<AllDevicesPage> createState() => _AllDevicesPage();
}

class _AllDevicesPage extends State<AllDevicesPage> {
  // Dummy data for testing, replace this with your actual data
  List<Device> devices = [
    Device(name: 'Pressure Device', imagePath: 'images/pressure.png'),
    Device(name: 'WeelChair', imagePath: 'images/weelchair2.png'),
    Device(name: 'Finger Tip', imagePath: 'images/finger_tip.png'),
    Device(name: 'Diabetes Device', imagePath: 'images/Diabetes_device.png'),
    Device(name: 'Oxygen Generator', imagePath: 'images/oxygen_generator.png'),
    Device(name: 'Medical bed', imagePath: 'images/Diabetes_device.png'),
    // Add more devices as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Devices"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: (devices.length / 2).ceil(), // Number of rows
          itemBuilder: (context, rowIndex) {
            return Column(
              children: [
                Row(
                  children: [
                    _buildLargeBox(devices[rowIndex * 2]),
                    SizedBox(width: 16),
                    if (rowIndex * 2 + 1 < devices.length)
                      _buildLargeBox(devices[rowIndex * 2 + 1]),
                  ],
                ),
                SizedBox(height: 16), // Add space between rows
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLargeBox(Device device) {
    return Expanded(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFF1C8892),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              device.imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              device.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
               
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Device {
  final String name;
  final String imagePath;

  Device({required this.name, required this.imagePath});
}
