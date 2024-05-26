import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/supplierDeviceInstructions.dart';
import 'package:test/sections/MedicalDevicesSection/supplierItemCart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';

class SupplierDeviceDetails extends StatefulWidget {
  final String userEmail;
  final int index;
  final String supplierName;

  SupplierDeviceDetails(
      {Key? key,
      required this.index,
      required this.userEmail,
      required this.supplierName})
      : super(key: key);

  @override
  State<SupplierDeviceDetails> createState() => _SupplierDeviceDetailsState();
}

class _SupplierDeviceDetailsState extends State<SupplierDeviceDetails> {
  int weeks = 1;

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF1C8892),
          title: Text(
            "Device details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            Consumer<MyProvider>(
              builder: (context, value, child) => value.cart.length > 0
                  ? badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -8, end: 3),
                      badgeColor: Color(0xFF1C8892),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SupplierItemCart(
                                    weekForRent: weeks,
                                  ),
                                  type: PageTransitionType.fade));
                        },
                        icon: Icon(
                          FontAwesomeIcons.cartShopping,
                          color: Colors.white,
                        ),
                      ),
                      badgeContent: Text(value.cart.length.toString(),
                          style: TextStyle(color: Colors.white)),
                    )
                  : SizedBox(),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: SupplierDeviceInstruction(
                          index: widget.index,
                        ),
                        type: PageTransitionType.fade),
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.list,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<MyProvider>(
            builder: (context, value, child) {
              List<Widget> carouselItems = [
                Image.network(
                  value.items![widget.index].deviceImages[0],
                  width: 400,
                ),
                Image.network(value.items![widget.index].deviceImages[1]),
                Image.network(value.items![widget.index].deviceImages[2]),
              ];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: CarouselSlider(
                              items: carouselItems,
                              options: CarouselOptions(
                                height: mainh * .50,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                              ),
                            ),
                          ),
                          value.items![widget.index].deviceAavailability == true
                              ? Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1C8892),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          "Available",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                )
                              : Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          "Not Available",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                )
                        ],
                      ),
                    ),
                    SizedBox(height: mainh * .02),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.items![widget.index].deviceName
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    SizedBox(height: mainh * .005),
                                    Text(
                                      "by ${widget.supplierName}",
                                      style: TextStyle(color: Colors.grey[800]),
                                    )
                                  ],
                                ),
                                SizedBox(width: 15),
                                value.items![widget.index].deviceBuyPrice !=
                                            null &&
                                        value.items![widget.index]
                                            .deviceBuyPrice.isNotEmpty
                                    ? Flexible(
                                        child: Text(
                                          "${value.items![widget.index].deviceBuyPrice} JOD",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 3,
                                              fontSize: 16,
                                              color: Color(0xFF1C8892)),
                                        ),
                                      )
                                    : Flexible(
                                        child: Text(
                                          "${value.items![widget.index].deviceRentPrice} JOD / Week",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0,
                                            fontSize: 14,
                                            color: Color(0xFF1C8892),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: mainh * 0.04),
                            Text("Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 16)),
                            SizedBox(height: mainh * .005),
                            Text(value.items![widget.index].deviceDescription),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mainh * 0.02),
                    value.items![widget.index].deviceRentPrice != null &&
                            value
                                .items![widget.index].deviceRentPrice.isNotEmpty
                        ? Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Price Details:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1C8892),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            "Required",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ).animate().move()
                                    ],
                                  ),
                                  SizedBox(height: mainh * .005),
                                  Row(
                                    children: [
                                      Text(
                                          "Rent ${value.items![widget.index].deviceRentPrice} per week"),
                                      Spacer(flex: 5),
                                      DropdownButton<int>(
                                        value: weeks,
                                        onChanged: (int? value) {
                                          setState(() {
                                            weeks = value!;
                                          });
                                        },
                                        items: List.generate(
                                          12,
                                          (index) => DropdownMenuItem<int>(
                                            value: index + 1,
                                            child: Text(
                                                '${index + 1} week${index + 1 > 1 ? 's' : ''}'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MyProvider>(
            builder: (context, value, child) => ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF1C8892)),
              ),
              onPressed: () {
                if (value.items![widget.index].deviceAavailability == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                      content: Text(
                        "${value.items![widget.index].deviceName} Not Available",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  );
                } else {
                  // add item to cart
                  //
                  context
                      .read<MyProvider>()
                      .additem(item: value.items![widget.index]);
                  //
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xFF1C8892),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                      content: Text(
                        "${value.items![widget.index].deviceName} added to cart ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.cartShopping,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
