import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/supplierRating.dart';
import 'package:test/sections/MedicalDevicesSection/supplierItemCart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test/sections/MedicalDevicesSection/supplierDeviceDetails.dart';
import 'package:test/sections/MedicalDevicesSection/supplierinfo.dart';

class SupplierDetails extends StatefulWidget {
  final int index;
  final String userEmail;
  final String supplierId;

  const SupplierDetails({
    Key? key,
    required this.index,
    required this.supplierId,
    required this.userEmail,
  }) : super(key: key);

  @override
  _SupplierDetailsState createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MyProvider>();
      provider.getItems(supplier_id: widget.supplierId);
      provider.getUserSpplierReview(supplier_id: widget.supplierId);
    });
  }

  double overallRating = 0.0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Consumer<MyProvider>(
            builder: (context, value, child) => Text(
              value.suppliers![widget.index].name,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
            ),
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
              size: width * 0.05,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<MyProvider>(
                builder: (context, value, child) => Container(
                  width: double.infinity,
                  height: height / 3.3,
                  child: Stack(
                    children: [
                      Image.network(
                        value.suppliers![widget.index].supplierCover,
                        fit: BoxFit.cover,
                        height: height / 5,
                        width: double.infinity,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          width: width / 1.2,
                          height: height / 4.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: height / 10,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width / 5,
                                        height: height / 10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          child: Image.network(
                                            value.suppliers![widget.index]
                                                .logoImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.suppliers![widget.index]
                                                  .name,
                                              style: TextStyle(
                                                  fontSize: width * 0.045,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: width * 0.04,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            child:
                                                                SupplierRating(
                                                              userEmail: widget
                                                                  .userEmail,
                                                              supplierId: widget
                                                                  .supplierId,
                                                            ),
                                                            type:
                                                                PageTransitionType
                                                                    .fade));
                                                  },
                                                  child: Consumer<MyProvider>(
                                                    builder: (context, value,
                                                        child) {
                                                      if (value
                                                              .supplierReview ==
                                                          null) {
                                                        return SizedBox();
                                                      }
                                                      return Text(
                                                        "(${value.supplierReview!.length.toString()} Ratings)",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize:
                                                              width * 0.035,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          width: width / 16,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.all(width * 0.01),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.transparent,
                                                border: Border.all(width: 0),
                                              ),
                                              child: Icon(
                                                FontAwesomeIcons.info,
                                                size: width * 0.03,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: SupplierInfo(
                                                      index: widget.index),
                                                  type:
                                                      PageTransitionType.fade));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: height / 10,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _makePhoneCall(value
                                                  .suppliers![widget.index]
                                                  .phoneNumber);
                                            },
                                            icon: Icon(Icons.call,
                                                color: Color(0xFF1C8892),
                                                size: width * 0.07),
                                          ),
                                          Text(
                                            'Call',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: width * 0.04),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.04),
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _launchWebsite(
                                                      website: value
                                                          .suppliers![
                                                              widget.index]
                                                          .website);
                                                },
                                                icon: Icon(Icons.link,
                                                    color: Color(0xFF1C8892),
                                                    size: width * 0.07),
                                              ),
                                              Text(
                                                'Website',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: width * 0.04),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _sendEmail(
                                                  emailAddress: value
                                                      .suppliers![widget.index]
                                                      .emailAddress,
                                                  supplierName: value
                                                      .suppliers![widget.index]
                                                      .name);
                                            },
                                            icon: Icon(Icons.email,
                                                color: Color(0xFF1C8892),
                                                size: width * 0.07),
                                          ),
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: width * 0.04),
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
              ),
              SizedBox(
                height: height * 0.02,
              ),
              DisplayItems(),
            ],
          ),
        ),
        floatingActionButton: CircleAvatar(
          radius: width * 0.08,
          backgroundColor: Color(0xFF1C8892),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.cartShopping,
              size: width * 0.05,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: SupplierItemCart(
                      userEmail: widget.userEmail,
                      supplierId: widget.supplierId,
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
    double width = MediaQuery.of(context).size.width;
    return Consumer<MyProvider>(
      builder: (context, value, child) {
        if (value.isFetching) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF1C8892),
            ),
          );
        }
        return value.items != null && value.items!.isNotEmpty
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.items!.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SupplierDeviceDetails(
                              index: index,
                              userEmail: widget.userEmail,
                              supplierId: widget.supplierId,
                              supplierName: value.suppliers![widget.index].name,
                            ),
                            type: PageTransitionType.fade));
                  },
                  child: UnconstrainedBox(
                    child: Container(
                      margin: EdgeInsets.only(top: mainh * .005),
                      width: mainw * .95,
                      height: mainh * .2,
                      child: LayoutBuilder(
                        builder: (context, constraints) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: mainh / 6,
                              child: Row(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: mainw / 3,
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
                                    width: mainw * 0.04,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.items![index].deviceName
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: width * 0.045,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                          ),
                                          SizedBox(
                                            height: mainh * 0.01,
                                          ),
                                          Text(
                                            value.items![index]
                                                .deviceDescription,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: width * 0.035,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          value.items![index].deviceBuyPrice
                                                  .isNotEmpty
                                              ? Text(
                                                  "Device Price: ${value.items![index].deviceBuyPrice}JD",
                                                  style: TextStyle(
                                                    fontSize: width * 0.04,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  "Rent per week: ${value.items![index].deviceRentPrice}JD",
                                                  style: TextStyle(
                                                    fontSize: width * 0.04,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
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
                ).animate().fade(),
              )
            : value.items == null
                ? Container(
                    width: mainw,
                    height: mainh * 0.1,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: mainw,
                    height: mainh * 0.1,
                    alignment: Alignment.center,
                    child: Text(
                      "No Devices added yet",
                      style: TextStyle(fontSize: width * 0.04),
                    ),
                  );
      },
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      print("Error launching phone call");
    }
  }
  // String telScheme = 'tel:$phoneNumber';
  // try {
  //   if (await canLaunch(telScheme)) {
  //     await launch(telScheme);
  //   } else {
  //     throw 'Could not launch $telScheme';
  //   }
  // } catch (e) {
  //   print('Error launching phone call: $e');
  // }
}

void _sendEmail(
    {required String emailAddress, required String supplierName}) async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
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

void _launchWebsite({required String website}) async {
  final String url = website;

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
