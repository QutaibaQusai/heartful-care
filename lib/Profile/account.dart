import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  // bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text(
        //     "Your Personal Information",
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: GoogleFonts.poppins().fontFamily,
        //         fontWeight: FontWeight.bold),
        //   ),
        //   backgroundColor: Color(0xFF1C8892),
        // ),
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  color: Color(0xFF1C8892),
                ),
                Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 80, // Image radius
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTip7Jkt7Y8vUdUJ1oxUd-FzIf6rVG-wV4q7FOBHutv&s'),
                      ),
                    ),
                    Text(
                      "@Qutaiba makahleh",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                    Text(
                      "developer@appshin.com",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   "Personal Information".toUpperCase(),
                    //   style: TextStyle(
                    //       fontSize: 25,
                    //       fontFamily: GoogleFonts.poppins().fontFamily,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.fileSignature,
                          color: Color(0xFF1C8892),
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(
                              "Qutaiba",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.mobileScreenButton,
                          color: Color(0xFF1C8892),
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mobile",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(
                              "+962795999114",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.envelope,
                          color: Color(0xFF1C8892),
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(
                              "Qutaiba.makahleh@gmail.com",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.locationDot,
                          color: Color(0xFF1C8892),
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(
                              "Amman",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Widget buildTextField({
//     required String labelText,
//     required String placeholder,
//     required bool isPasswordTextField,
//     required IconData icon,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 35.0),
//       child: TextField(
//         obscureText: isPasswordTextField ? showPassword : false,
//         style: TextStyle(
//           color: Colors.white,
//           fontFamily: GoogleFonts.poppins().fontFamily,
//         ),
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(50),
//             borderSide: BorderSide(
//               color: const Color(0xFF1C8892),
//               width: 2.0,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(50),
//             borderSide: BorderSide(
//               color: const Color(0xFF1C8892),
//               width: 3.0,
//             ),
//           ),
//           prefixIcon: Icon(
//             icon,
//             color: const Color(0xFF1C8892),
//           ),
//           labelText: labelText,
//           labelStyle: TextStyle(
//             color: const Color(0xFF1C8892),
//             fontFamily: GoogleFonts.poppins().fontFamily,
//           ),
//         ),
//       ),
//     );
//   }
}
