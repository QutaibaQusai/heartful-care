import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  //final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forget \nPassword",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            letterSpacing: 1,
                            color: Color(0xFF1C8892)),
                      ),
                      Text(
                        "Select which contact details should we use to reset your password:",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2.4,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            //fontWeight: FontWeight.w600,
                            color: Colors.grey[700]),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                          decoration: BoxDecoration(
                              color: Color(0xFF1C8892),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  FontAwesomeIcons.mobileScreenButton,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Via sms:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          height: 1.8),
                                    ),
                                    Text(
                                      "+962 **********",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      InkWell(
                        onTap: () {
                       //TODO
                       



                        

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF1C8892),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Via email:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          height: 1.8),
                                    ),
                                    Text(
                                      "****qu@gmail.com",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
