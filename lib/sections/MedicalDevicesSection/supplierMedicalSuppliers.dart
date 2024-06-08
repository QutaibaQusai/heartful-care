import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/provider/myprovider.dart';
import 'package:test/sections/MedicalDevicesSection/supplerDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierMedicalSupplier extends StatefulWidget {
  final String userEmail;
  const SupplierMedicalSupplier({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<SupplierMedicalSupplier> createState() => _MedicalState();
}

class _MedicalState extends State<SupplierMedicalSupplier> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyProvider>().getSppliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Suppliers",
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
          ),
          backgroundColor: Color(0xFF1C8892),
          centerTitle: true,
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: width * 0.05,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: displaySuppliers(),
        ),
      ),
    );
  }

  Widget displaySuppliers() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<MyProvider>(
      builder: (context, value, child) {
        if (value.isFetching) {
          return Container(
            height: height - 56,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF1C8892),
              ),
            ),
          );
        }
        if (value.suppliers == null) {
          return Container(
            height: height - 56,
            child: Center(child: Text("No Supplier yet")),
          );
        }
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: value.suppliers!.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SupplierDetails(
                              index: index,
                              supplierId: value.suppliers![index].Id,
                              userEmail: widget.userEmail,
                            ),
                            type: PageTransitionType.fade));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: width * 0.04),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Color(0xFFD1E7E9),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      height: height * 0.3,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: height * 0.15,
                                child: Image.network(
                                  value.suppliers![index].supplierCover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.09,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        value.suppliers![index].name
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: width * 0.05,
                                        ),
                                        Text(
                                          value
                                              .calculateOverallRating()
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: width * 0.045),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: CircleAvatar(
                                radius: width * 0.06,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      _makePhoneCall(
                                          value.suppliers![index].phoneNumber);
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      color: Color(0xFF1C8892),
                                      size: width * 0.05,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                width: width * 0.25,
                                height: width * 0.25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Image.network(
                                  value.suppliers![index].logoImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fade(),
                ));
      },
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
}
