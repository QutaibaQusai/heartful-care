import 'package:flutter/material.dart';
import 'package:test/sections/NurseCenterSection/subcriptionConfirmation.dart';

class Subscribe extends StatefulWidget {
  final String pricePreMonth;
  final String pricePersixMonths;
  final String pricePerthreeMonths;
  const Subscribe(
      {Key? key,
      required this.pricePreMonth,
      required this.pricePersixMonths,
      required this.pricePerthreeMonths})
      : super(key: key);

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Subscription Plans',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        'Subscribe now for our 1-month plan and start saving instantly',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  SubscriptionPlanCard(
                    name: '3 Months',
                    price: widget.pricePerthreeMonths + 'JD',
                    description: 'Save big with our 3-month subscription plan!',
                    onPressed: () {
                      // Add logic for 3 months subscription
                    },
                  ),
                  SizedBox(height: 20),
                  SubscriptionPlanCard(
                    name: '6 Months',
                    price: widget.pricePersixMonths + 'JD',
                    description: 'Subscribe for 6 months and save more!',
                    onPressed: () {
                      // Add logic for 3 months subscription
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final VoidCallback onPressed;

  const SubscriptionPlanCard({
    required this.name,
    required this.price,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Color(0xFF1C8892), // Card background color
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,

                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionConfirmationPage(),
                  ),
                );
              },
              child: Text(
                'Subscribe Now ',
                style: TextStyle(
                  color: Color(0xFF1C8892), // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
