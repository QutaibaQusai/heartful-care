import 'package:flutter/material.dart';

class SettingFirstPage extends StatefulWidget {
  const SettingFirstPage({super.key});

  @override
  State<SettingFirstPage> createState() => _SettingFirstPage();
}

class _SettingFirstPage extends State<SettingFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Settings',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color(0xFF1C8892),
                ),
                SizedBox(width: 10),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            // Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildAccountOption(context, "Account Info"),
            buildAccountOption(context, "Saved Addresses"),
            buildAccountOption(context, "Change Email"),
            buildAccountOption(context, "Change Password"),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Color(0xFF1C8892),
                ),
                SizedBox(width: 10),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

GestureDetector buildAccountOption(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              //fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.black),
        ],
      ),
    ),
  );
}
