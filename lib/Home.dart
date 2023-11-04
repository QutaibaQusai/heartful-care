import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/login.dart';
import 'package:test/sections/medical_devices.dart';
import 'package:test/sections/nurse_centers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF1C8892),
      // ),
      body: Column(
        children: [
          Container(
            // this line for making a divided screen
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              color: const Color(0xFF1C8892),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hey there !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "log in or create an account for a\nnew experience.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      // Navigate to the second page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "LOGIN".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.openSans().fontFamily,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                  child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the second page when the first box is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NurseCenters()),
                      );
                    },
                    child: SizedBox(
                        width: 170.0,
                        height: 170.0,
                        child: Card(
                          color: Colors.white,
                          elevation: 9.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/nurse.png",
                                    width: 90.0,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Text(
                                    "Nurse Center",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the second page when the first box is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Medical()),
                      );
                    },
                    child: SizedBox(
                      width: 170.0,
                      height: 170.0,
                      child: Card(
                        color: Colors.white,
                        elevation: 9.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/medicalD.png",
                                  width: 70.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  "Medical Devices",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.home,
                        size: 40,
                      ),
                      color: const Color(0xFF1C8892)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        size: 40, color: Color(0xFF1C8892)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Color(0xFF1C8892),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
