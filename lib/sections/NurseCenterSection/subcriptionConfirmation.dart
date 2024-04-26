import 'package:flutter/material.dart';

class SubscriptionConfirmationPage extends StatefulWidget {
  const SubscriptionConfirmationPage({super.key});

  @override
  State<SubscriptionConfirmationPage> createState() =>
      _SubscriptionConfirmationPage();
}

class _SubscriptionConfirmationPage
    extends State<SubscriptionConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Subscription Confrirmation',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
