import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CentersHome extends StatefulWidget {
  const CentersHome({super.key});

  @override
  State<CentersHome> createState() => _CentersHome();
}

class _CentersHome extends State<CentersHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Centers Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        // Customize the AppBar as needed
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('images/lottie/Animation - 1706116974821.json',
                  width: 800),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
