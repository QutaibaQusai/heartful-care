import 'package:flutter/material.dart';

class SubscriptionPlanCard extends StatefulWidget {
  final String name;
  final String price;
  final String description;
  final VoidCallback onPressed;
  const SubscriptionPlanCard({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.onPressed,
  });

  @override
  State<SubscriptionPlanCard> createState() => _SubscriptionPlanCardState();
}

class _SubscriptionPlanCardState extends State<SubscriptionPlanCard> {
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
              widget.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.price,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,

                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  widget.onPressed, // using the callback provided from outside,
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
