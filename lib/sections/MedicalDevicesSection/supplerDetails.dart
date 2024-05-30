import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/ratingSupp.dart';
import 'package:test/sections/MedicalDevicesSection/supplierItemCart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test/sections/MedicalDevicesSection/supplierDeviceDetails.dart';
import 'package:test/sections/MedicalDevicesSection/supplierinfo.dart';

class SupplierDetails extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String logoImage;
  final String website;
  final String location;
  final String description;
  final String paymentOption;
  final String userEmail;
  final String supplierCover;
  final String supplierId;
  const SupplierDetails({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.website,
    required this.location,
    required this.description,
    required this.paymentOption,
    required this.logoImage,
    required this.userEmail,
    required this.supplierCover,
    required this.supplierId,
  }) : super(key: key);

  @override
  _SupplierDetailsState createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  @override
  void initState() {
    context.read<MyProvider>().getItems(supplier_id: widget.supplierId);
    super.initState();
  }

  double overallRating = 0.0;
  List<bool> onClick = [true, false, false];

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1C8892),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              //
              // delete item cart
              context.read<MyProvider>().cart.clear();
              //
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3.3,
                child: Stack(
                  children: [
                    Image.network(
                      widget.supplierCover,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 5,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 4.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height: 100,
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
                                          widget.logoImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.name,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RatingSupplier(
                                                                  userEmail: widget
                                                                      .userEmail,
                                                                  supplierId: widget
                                                                      .supplierId,
                                                                  onOverallRatingChanged:
                                                                      (newOverallRating) {},
                                                                )));
                                                  },
                                                  child: Text(
                                                    "(Reviews)",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                16,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.transparent,
                                              border: Border.all(width: 0),
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.info,
                                              size: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SupplierInfo(
                                              supplierName: widget.name,
                                              supplierPhoneNumber:
                                                  widget.phoneNumber,
                                              supplierEmailAddress:
                                                  widget.emailAddress,
                                              supplierWebsite: widget.website,
                                              supplierLocation: widget.location,
                                              supplierDescription:
                                                  widget.description,
                                              paymentOption:
                                                  widget.paymentOption,
                                              logoImage: widget.logoImage,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _makePhoneCall(widget.phoneNumber);
                                          },
                                          icon: Icon(Icons.call,
                                              color: Color(0xFF1C8892)),
                                        ),
                                        Text(
                                          'Call',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        right: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _launchWebsite();
                                              },
                                              icon: Icon(Icons.link,
                                                  color: Color(0xFF1C8892)),
                                            ),
                                            Text(
                                              'Website',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _sendEmail();
                                          },
                                          icon: Icon(Icons.email,
                                              color: Color(0xFF1C8892)),
                                        ),
                                        Text(
                                          'Email',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // Display items .
              DisplayItems(),
            ],
          ),
        ),
        floatingActionButton: CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFF1C8892),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.cartShopping,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: SupplierItemCart(
                      userEmail: widget.userEmail, supplierId: widget.supplierId,
                    ),
                    type: PageTransitionType.bottomToTop,
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget DisplayItems() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<MyProvider>(
      builder: (context, value, child) => value.items != null &&
              value.items!.isNotEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.items!.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  //
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SupplierDeviceDetails(
                            index: index,
                            userEmail: widget.userEmail,
                            supplierName: widget.name, supplierId: widget.supplierId,
                          ),
                          type: PageTransitionType.fade));
                  //
                },
                child: UnconstrainedBox(
                  child: Container(
                    margin: EdgeInsets.only(top: mainh * .005),
                    width: mainw * .95,
                    height: mainh * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Image.network(
                                    value.items![index].deviceImages[1],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.items![index].deviceName
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        value.items![index].deviceDescription,
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                      ),
                                      Expanded(child: Container()),
                                      value.items![index].deviceBuyPrice !=
                                                  null &&
                                              value.items![index].deviceBuyPrice
                                                  .isNotEmpty
                                          ? Text(
                                              "Device Price: ${value.items![index].deviceBuyPrice}JD")
                                          : Text(
                                              "Rent per week: ${value.items![index].deviceRentPrice}JD")
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : value.items == null
              ? Container(
                  width: mainw,
                  height: mainh * 10 / 100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: mainw,
                  height: mainh * 10 / 100,
                  alignment: Alignment.center,
                  child: Text("No Devices added yet"),
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
    }
  }

  void _sendEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.emailAddress,
      queryParameters: {
        'subject': 'Subject Here',
        'body': 'Body Here',
      },
    );

    final String _emailLaunchUriString = _emailLaunchUri.toString();

    try {
      await launch(_emailLaunchUriString);
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  void _launchWebsite() async {
    final String url = widget.website;

    if (url.isNotEmpty) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        final String googleUrl = 'https://www.google.com';
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not launch $googleUrl';
        }
      }
    } else {
      final String googleUrl = 'https://www.google.com';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    }
  }
}
