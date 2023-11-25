import 'package:flutter/material.dart';

class SettingFirstPage extends StatefulWidget {
  const SettingFirstPage({Key? key}) : super(key: key);

  @override
  State<SettingFirstPage> createState() => _SettingFirstPage();
}

class _SettingFirstPage extends State<SettingFirstPage> {
  bool notification1 = true;
  bool notification2 = false;
  String selectedLanguage = 'English';
  String selectedLocation = 'Not set';
  List<String> ammanAreas = [
    'Dair Ghbar',
    'Sweileh',
    'Abdoun',
    'Khalda',
    'Rabyeh',
    'Om al somaq',
    'Daheyet Al Rashed',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            buildSectionHeader(Icons.person, "Account"),
            buildAccountOption(context, "Account Info"),
            buildAccountOption(context, "Saved Addresses"),
            buildAccountOption(context, "Change Email"),
            buildAccountOption(context, "Change Password"),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.notifications, "Notifications"),
            buildNotificationOption(context, "News for you", notification1,
                (value) => setState(() => notification1 = value)),
            buildNotificationOption(context, "App updates", notification2,
                (value) => setState(() => notification2 = value)),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.language, "Language"),
            buildLanguageOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.location_on, "Location"),
            buildLocationOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
            buildSectionHeader(Icons.exit_to_app, "Logout"),
            buildLogoutOption(context),
            Divider(height: 20, thickness: 0.5),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color(0xFF1C8892),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationOption(BuildContext context, String title, bool value,
      Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF1C8892),
            //inactiveColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'English';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('English'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'Arabic';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Arabic'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLocationInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Location',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            children: ammanAreas
                .map((area) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLocation = area;
                        });
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Text(
                          area,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform logout action
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Widget buildLanguageOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLanguageDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLanguage,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildLocationOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLocationInputDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLocation,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.edit_location, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildLogoutOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLogoutDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.logout, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
