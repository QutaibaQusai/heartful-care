import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/sections/MedicalDevicesSection/itemCart.dart';
import 'package:badges/badges.dart' as badges;

class SupplierDeviceDetails extends StatefulWidget {
  final String deviceName;
  final String deviceDescription;
  final String priceForBuying;
  final String priceForRent;
  final String userEmail;
  final String deviceImage1;
  final String deviceImage2;
  final String deviceImage3;

  const SupplierDeviceDetails({
    Key? key,
    required this.deviceName,
    required this.deviceDescription,
    required this.priceForBuying,
    required this.priceForRent,
    required this.userEmail,
    required this.deviceImage1,
    required this.deviceImage2,
    required this.deviceImage3,
  }) : super(key: key);

  @override
  State<SupplierDeviceDetails> createState() => _SupplierDeviceDetailsState();
}

class _SupplierDeviceDetailsState extends State<SupplierDeviceDetails> {
  int quantity = 1;
  int weeks = 1;
  int currentPage = 0;
  String? priceOption;
  int cartItemCount = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      widget.deviceImage1,
      widget.deviceImage2,
      widget.deviceImage3,
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            "Device Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            //   if (priceOption != null)
            //     badges.Badge(
            //       position: badges.BadgePosition.topEnd(top: -8, end: 3),
            //       showBadge: cartItemCount > 0,
            //       badgeContent: Text(cartItemCount.toString()),
            //       badgeColor: Colors.white,
            //       child: IconButton(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => ItemCart(
            //                 itemName: widget.deviceName,
            //                 itemPrice: priceOption == 'Buy'
            //                     ? widget.priceForBuying
            //                     : widget.priceForRent,
            //                 itemOption: priceOption!,
            //                 quantity: quantity,
            //                 weeks: weeks,
            //                 onItemAddedToCart: () {
            //                   setState(() {
            //                     cartItemCount++;
            //                   });
            //                 },
            //                 userEmail: widget.userEmail,
            //                 deviceImage1: widget.deviceImage1,
            //               ),
            //             ),
            //           );
            //         },
            //         icon: Icon(
            //           FontAwesomeIcons.cartShopping,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(),
                child: PageView.builder(
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => buildDot(index),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.deviceName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        widget.priceForBuying.isNotEmpty &&
                                widget.priceForRent.isEmpty
                            ? Text(
                                "${widget.priceForBuying} JD",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : widget.priceForRent.isNotEmpty &&
                                    widget.priceForBuying.isEmpty
                                ? Text(
                                    "${widget.priceForRent} per week",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "${widget.priceForBuying}JD \n|${widget.priceForRent}JD ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Device Description:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.deviceDescription,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Price Details:",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Radio<String>(
                        //           value: 'Buy',
                        //           groupValue: priceOption,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               priceOption = value!;
                        //             });
                        //           },
                        //           materialTapTargetSize:
                        //               MaterialTapTargetSize.shrinkWrap,
                        //           activeColor: Color(0xFF1C8892),
                        //         ),
                        //         Text('Buy for ${widget.priceForBuying} JD'),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Radio<String>(
                        //           value: 'Rent',
                        //           groupValue: priceOption,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               priceOption = value!;
                        //             });
                        //           },
                        //           materialTapTargetSize:
                        //               MaterialTapTargetSize.shrinkWrap,
                        //           activeColor: Color(0xFF1C8892),
                        //         ),
                        //         Text(
                        //             'Rent per week for ${widget.priceForRent} JD'),
                        //         Spacer(flex: 5),
                        //         priceOption == 'Rent'
                        //             ? DropdownButton<int>(
                        //                 value: weeks,
                        //                 onChanged: (int? value) {
                        //                   setState(() {
                        //                     weeks = value!;
                        //                   });
                        //                 },
                        //                 items: List.generate(
                        //                   12,
                        //                   (index) => DropdownMenuItem<int>(
                        //                     value: index + 1,
                        //                     child: Text('${index + 1} weeks'),
                        //                   ),
                        //                 ),
                        //               )
                        //             : SizedBox(),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.priceForRent.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: decrementQuantity,
                            icon: Icon(Icons.remove),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            onPressed: incrementQuantity,
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    )
                  : Text(""),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cartItemCount++;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1C8892),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? Color(0xFF1C8892) : Colors.grey,
      ),
    );
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }
}
