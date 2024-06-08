import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/supplierCheckOut.dart';

class SupplierItemCart extends StatefulWidget {
  final int? weekForRent;
  final String userEmail;
  final String supplierId;
  const SupplierItemCart({
    Key? key,
    this.weekForRent,
    required this.userEmail,
    required this.supplierId,
  }) : super(key: key);

  @override
  State<SupplierItemCart> createState() => _ItemCart();
}

class _ItemCart extends State<SupplierItemCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart",
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
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayItems(),
              SizedBox(height: height * 0.015),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<MyProvider>(
          builder: (context, value, child) {
            double totalBuyPrice = 0.0;
            double totalRent = 0.0;
            for (var item in value.cart) {
              totalBuyPrice += double.tryParse(item.deviceBuyPrice) ?? 0.0;
              totalRent += double.tryParse(item.deviceRentPrice) ?? 0.0;
            }
            int weeksForRent = widget.weekForRent ?? 1;

            double total = (totalBuyPrice + totalRent) * weeksForRent;
            return value.cart.isNotEmpty
                ? Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.02,
                      horizontal: width * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, -15),
                          blurRadius: 20,
                          color: const Color(0xFFDADADA).withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: "Total:\n",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.045),
                                  children: [
                                    TextSpan(
                                      text: "${total.toString()} JD",
                                      style: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1C8892),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: SupplierCheckout(
                                        userEmail: widget.userEmail,
                                        supplierId: widget.supplierId,
                                      ),
                                      type: PageTransitionType.fade,
                                    ),
                                  );
                                },
                                child: Text(
                                  "Check Out",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 0,
                    height: 0,
                  );
          },
        ),
      ),
    );
  }

  Widget displayItems() {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Consumer<MyProvider>(
      builder: (context, value, child) => value.cart != null &&
              value.cart.isNotEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.cart.length,
              itemBuilder: (context, index) => UnconstrainedBox(
                child: Container(
                  margin: EdgeInsets.only(top: height * 0.015),
                  width: width * 0.95,
                  height: height * 0.13,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: height * 0.18,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Container(
                                height: width * 0.2,
                                width: width * 0.2,
                                child: Image.network(
                                  value.cart[index].deviceImages[1],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Container(
                            width: width * 0.40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    value.cart[index].deviceName.toUpperCase(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  value.cart[index].deviceDescription,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: width * 0.035),
                                ),
                                value.cart[index].deviceBuyPrice != null &&
                                        value.cart[index].deviceBuyPrice
                                            .isNotEmpty
                                    ? Text(
                                        "${value.cart[index].deviceBuyPrice} JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.03),
                                      )
                                    : Text(
                                        "${value.cart[index].deviceRentPrice} JOD for ${widget.weekForRent} Week",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.03),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: width * 0.05,
                        child: IconButton(
                          onPressed: () {
                            context.read<MyProvider>().deleteitem(index: index);
                          },
                          icon: Icon(
                            FontAwesomeIcons.trashCan,
                            color: Colors.red,
                            size: width * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: Text(
                "No Items found!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.05),
              ),
            ),
    );
  }
}
