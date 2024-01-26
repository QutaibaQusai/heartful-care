import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NurseCenters extends StatelessWidget {
  const NurseCenters({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(251, 242, 237, 237),
        appBar: AppBar(
          title: Text("Find your center"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 6,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 150.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Colors.blue, // Set your desired background color
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "images/WhatsApp Image 2024-01-26 at 14.17.39_b4e6076d.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "AL SAKHA",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.star,
                                        size: 13,
                                        color: Colors.yellowAccent,
                                      ),
                                      Text(" 4.5 Reviews "),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      size: 13,
                                    ),
                                    Text(" 6:00AM-3:00PM"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
