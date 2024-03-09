import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupplierInfo extends StatefulWidget {
  final String supplierName;
  final String supplierPhoneNumber;
  final String supplierEmailAddress;
  final String supplierWebsite;
  final String supplierLocation;
  final String supplierDescription;
  final String paymentOption;

  const SupplierInfo(
      {super.key,
      required this.supplierName,
      required this.supplierPhoneNumber,
      required this.supplierEmailAddress,
      required this.supplierWebsite,
      required this.supplierLocation,
      required this.supplierDescription,
      required this.paymentOption});

  @override
  State<SupplierInfo> createState() => _SupplierInfoState();
}

class _SupplierInfoState extends State<SupplierInfo> {
  @override
  Widget build(BuildContext context) {
    String fullUrl = widget.supplierWebsite;
    Uri uri = Uri.parse(fullUrl);
    String websiteUrl = uri.host;

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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUNNBIv06ExHc1ukAR8kBj3xuKlWNOoBMZiAueAxVzj4Dw33zzZPDy1b7EqRUIJSgYrsQ&usqp=CAU",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.supplierName.toUpperCase(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: buildLocationRow(FontAwesomeIcons.mobile,
                      "Supplier Phone Number ", widget.supplierPhoneNumber),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Divider(
                    thickness: 1,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: buildLocationRow(FontAwesomeIcons.envelope,
                      "Supplier Email Address", widget.supplierEmailAddress),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Divider(
                    thickness: 1,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: buildLocationRow(
                      FontAwesomeIcons.globe, "Supplier Website", websiteUrl),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Divider(
                    thickness: 1,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: buildLocationRow(FontAwesomeIcons.locationArrow,
                      "Supplier Location", widget.supplierLocation),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Divider(
                    thickness: 1,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: buildLocationRow(FontAwesomeIcons.solidCreditCard,
                      "Payment Option", widget.paymentOption),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Divider(
                    thickness: 1,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.info,
                        color: Color(0xFF1C8892),
                        size: 28,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Supplier Description",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.supplierDescription),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationRow(IconData iconData, String text1, String text2) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Color(0xFF1C8892),
          size: 28,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(text2),
          ],
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
