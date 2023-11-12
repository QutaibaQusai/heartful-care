import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Home.dart';
import 'package:test/model/content_model.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onNextButtonPressed() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceIn,
    );
  }

  void onGetStartedButtonPressed() {
    // Handle the action for the "Get Started" button.
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Home();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Image.asset(contents[i].image,
                          width: MediaQuery.of(context).size.width),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                            color: Color(0xFF1C8892),
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          textAlign: TextAlign.center,
                          contents[i].discription,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 29, 17, 17),
                              height: 1.8,
                              fontSize: 14))
                    ],
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                contents.length, (index) => buildDot(index, context)),
          ),
          Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: currentIndex == contents.length - 1
                  ? onGetStartedButtonPressed
                  : onNextButtonPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF1C8892), // Text color
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Get Started" : "Next",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 9,
      width: currentIndex == index ? 15 : 10,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1C8892),
      ),
    );
  }
}
