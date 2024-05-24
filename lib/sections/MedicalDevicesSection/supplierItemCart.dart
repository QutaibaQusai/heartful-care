import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/supplierCheckOut.dart';

class SupplierItemCart extends StatefulWidget {
  const SupplierItemCart({
    Key? key,
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
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
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
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //

            displayItems(),

            //
            SizedBox(
              height: mainh * 1.5 / 100,
            )
          ],
        ),
      ),
      bottomNavigationBar:
          Consumer<MyProvider>(builder: (context, value, child) {
        double totalBuyPrice = 0.0;
        double totalRent = 0.0;
        for (var item in value.cart) {
          totalBuyPrice += double.tryParse(item.deviceBuyPrice) ?? 0.0;
          totalRent += double.tryParse(item.deviceRent) ?? 0.0;
        }
        double total = totalBuyPrice + totalRent;
        return value.cart.isNotEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                // height: 174,
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
                    )
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "${total.toString()} JD",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                                      child: SupplierCheckout(),
                                      type: PageTransitionType.fade));
                            },
                            child: const Text(
                              "Check Out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
            : Container(
                width: 0,
                height: 0,
              );
      }),
    ));
  }

  Widget displayItems() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<MyProvider>(
      builder: (context, value, child) => value.cart != null &&
              value.cart.isNotEmpty
          //
          //if the list of cart is not empty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.cart.length,
              itemBuilder: (context, index) => UnconstrainedBox(
                child: Container(
                  margin: EdgeInsets.only(top: mainh * .015),
                  width: mainw * .95,
                  height: mainh * .13,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: mainh * .18,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  value.cart[index].deviceImages[1],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: mainw * .40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    value.cart[index].deviceName.toUpperCase(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  value.cart[index].deviceDescription,
                                  maxLines: 2,
                                ),
                                // Spacer(),

                                // TODO
                                value.cart[index].deviceRent.isEmpty
                                    ? Text(
                                        "${value.cart[index].deviceBuyPrice} JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "${value.cart[index].deviceRent} JOD Per Week",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        // backgroundColor: Colors.red,
                        child: IconButton(
                            onPressed: () {
                              // delete item
                              context
                                  .read<MyProvider>()
                                  .deleteitem(index: index);
                            },
                            icon: Icon(FontAwesomeIcons.trashCan,
                                color: Colors.red, size: 15)),
                      )
                    ],
                  ),
                ),
              ),
            )
          //

          //if list of cart is empty
          : Container(
              alignment: Alignment.center,
              width: mainw,
              height: mainh,
              child: Text(
                "No Items found !",
                textAlign: TextAlign.center,
              ),
            ),
      //
    );
  }
}
