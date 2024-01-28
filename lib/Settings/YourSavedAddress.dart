import 'package:flutter/material.dart';
import 'package:test/Settings/addaddresspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YourSavedAddress extends StatefulWidget {
  final String userEmail;

  const YourSavedAddress({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<YourSavedAddress> createState() => _YourSavedAddressState();
}

class _YourSavedAddressState extends State<YourSavedAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Addresses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: true, // Center the title horizontally
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddAddressPage(userEmail: widget.userEmail),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        // Fetch the user's address data from Firestore
        future: fetchAddressData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use a ListView.builder to create a list of rows
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['label']!),
                  subtitle: Text(snapshot.data![index]['value']!),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, String>>> fetchAddressData() async {
    List<Map<String, String>> addressDataList = [];

    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userDoc.docs.isNotEmpty) {
        var userData = userDoc.docs[0].data();

        // Extract address data and add it to the list
        addressDataList.add({'label': 'Area', 'value': userData['Area'] ?? ""});
        addressDataList.add({
          'label': 'Address Nickname',
          'value': userData['Address nickname'] ?? ""
        });
        addressDataList
            .add({'label': 'Street', 'value': userData['Street'] ?? ""});
        addressDataList
            .add({'label': 'Building', 'value': userData['Building'] ?? ""});
        addressDataList
            .add({'label': 'Floor', 'value': userData['Floor'] ?? ""});
        addressDataList
            .add({'label': 'Apartment', 'value': userData['Apartment'] ?? ""});
        addressDataList.add({
          'label': 'Mobile Number',
          'value': userData['Mobile number'] ?? ""
        });
      }

      return addressDataList;
    } catch (e) {
      print('Error fetching user data:$e');
      return [];
    }
  }
}
