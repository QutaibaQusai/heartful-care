import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';

class SupplierInfo extends StatefulWidget {
  final int index;

  const SupplierInfo({
    super.key,
    required this.index,
  });

  @override
  State<SupplierInfo> createState() => _SupplierInfoState();
}

class _SupplierInfoState extends State<SupplierInfo> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    // String fullUrl = widget.supplierWebsite;
    // Uri uri = Uri.parse(fullUrl);
    // String websiteUrl = uri.host;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Supplier Information",
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: Consumer<MyProvider>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: width / 5,
                        height: height * 0.1,
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
                            value.suppliers![widget.index].logoImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Expanded(
                        child: Text(
                          value.suppliers![widget.index].name.toUpperCase(),
                          style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: buildLocationRow(
                        FontAwesomeIcons.mobile,
                        "Supplier Phone Number ",
                        value.suppliers![widget.index].phoneNumber),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Divider(
                      thickness: 1,
                      height: height * 0.03,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: buildLocationRow(
                        FontAwesomeIcons.envelope,
                        "Supplier Email Address",
                        value.suppliers![widget.index].emailAddress),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Divider(
                      thickness: 1,
                      height: height * 0.03,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: buildLocationRow(
                        FontAwesomeIcons.globe,
                        "Supplier Website",
                        value.suppliers![widget.index].website),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Divider(
                      thickness: 1,
                      height: height * 0.03,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: buildLocationRow(
                        FontAwesomeIcons.locationArrow,
                        "Supplier Location",
                        value.suppliers![widget.index].location),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Divider(
                      thickness: 1,
                      height: height * 0.03,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: buildLocationRow(
                        FontAwesomeIcons.solidCreditCard,
                        "Payment Option",
                        value.suppliers![widget.index].paymentOption),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Divider(
                      thickness: 1,
                      height: height * 0.03,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.info,
                          color: Color(0xFF1C8892),
                          size: width * 0.07,
                        ),
                        SizedBox(width: width * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Supplier Description",
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: height * 0.005),
                            Container(
                              width: width - 90, // Adjust width as needed
                              child: Text(
                                value.suppliers![widget.index].description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: width * 0.035),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationRow(IconData iconData, String text1, String text2) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Row(
      children: [
        Icon(
          iconData,
          color: Color(0xFF1C8892),
          size: width * 0.07,
        ),
        SizedBox(width: width * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: TextStyle(
                  fontSize: width * 0.04, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.005),
            Container(
              width: width * 0.65,
              child: Text(
                text2,
                style: TextStyle(fontSize: width * 0.035),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
