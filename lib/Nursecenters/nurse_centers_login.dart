import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/login_screen.dart';

class centersLogin extends StatefulWidget {
  const centersLogin({Key? key}) : super(key: key);

  @override
  State<centersLogin> createState() => _centersLogin();
}

class _centersLogin extends State<centersLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back! Glad ",
                            ),
                          ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
