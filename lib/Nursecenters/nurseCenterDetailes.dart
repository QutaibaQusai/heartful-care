import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailedNurseCenter extends StatefulWidget {
  @override
  State<DetailedNurseCenter> createState() => _DetailedNurseCenterState();
}

class _DetailedNurseCenterState extends State<DetailedNurseCenter> {
  @override
  Widget build(BuildContext context) {
    // Implement the detailed page UI here
    //   color: Color(0xFF1C8892),
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8892),
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.phoneFlip,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.3,
                    decoration: BoxDecoration(
                      color: Color(0xFF1C8892),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 180,
                      child: Image.asset(
                          "images/WhatsApp_Image_2024-01-27_at_13.11.06_132c59dc-removebg-preview.png"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AL SAKHA Center",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 3),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "8PM - 10PM",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1C8892),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                tabs: [
                                  Tab(text: 'Description'),
                                  Tab(text: 'Reviews'),
                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: TabBarView(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        'Add your description content here.',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        'Add your reviews content here.',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1C8892)),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Fill form".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.,
      ),
    );
  }
}
