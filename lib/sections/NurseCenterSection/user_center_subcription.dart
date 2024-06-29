import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/sections/NurseCenterSection/subcriptionConfirmation.dart';
import 'package:test/widgets/widget_subscription_plan_card.dart';

class UserCenterSubscription extends StatefulWidget {
  final String pricePreMonth;
  final String pricePersixMonths;
  final String pricePerthreeMonths;
  final String centerId;
  final String userEmail;
  const UserCenterSubscription({
    Key? key,
    required this.pricePreMonth,
    required this.pricePersixMonths,
    required this.pricePerthreeMonths,
    required this.centerId,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<UserCenterSubscription> createState() => _UserCenterSubscriptionState();
}

class _UserCenterSubscriptionState extends State<UserCenterSubscription> {
  @override
  Widget build(BuildContext context) {
    final isGuest = widget.userEmail.isEmpty;

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
          centerTitle: true,
          title: Text(
            'Subscription Plans',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SubscriptionPlanCard(
                      name: '1 Month',
                      price: widget.pricePreMonth + 'JD',
                      description:
                          'UserCenterSubscription now for our 1-month plan and start saving instantly',
                      onPressed: () {
                        if (!isGuest == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubscriptionConfirmationPage(
                                planPrice: widget.pricePreMonth,
                                planDuration: "1",
                                centerId: widget.centerId,
                                userEmail: widget.userEmail,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF1C8892),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Log in first",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                              duration: Duration(
                                  seconds: 1), // Set your custom duration here
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SubscriptionPlanCard(
                      name: '3 Months',
                      price: widget.pricePerthreeMonths + 'JD',
                      description:
                          'Save big with our 3-month subscription plan!',
                      onPressed: () {
                        if (!isGuest == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubscriptionConfirmationPage(
                                planPrice: widget.pricePerthreeMonths,
                                planDuration: "3",
                                centerId: widget.centerId,
                                userEmail: widget.userEmail,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF1C8892),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Log in first",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                              duration: Duration(
                                  seconds: 1), // Set your custom duration here
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SubscriptionPlanCard(
                      name: '6 Months',
                      price: widget.pricePersixMonths + 'JD',
                      description:
                          'UserCenterSubscription for 6 months and save more!',
                      onPressed: () {
                        if (!isGuest == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubscriptionConfirmationPage(
                                planPrice: widget.pricePersixMonths,
                                planDuration: "6",
                                centerId: widget.centerId,
                                userEmail: widget.userEmail,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF1C8892),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Log in first",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                              duration: Duration(
                                  seconds: 1), // Set your custom duration here
                            ),
                          );
                        }
                      },
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
}
