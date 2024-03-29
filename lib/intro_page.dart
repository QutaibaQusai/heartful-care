import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:test/home.dart';
import 'package:test/model/Intro_Model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/User%20login-Sginup/login_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

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
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Home(
        userEmail: '',
      );
    }));
  }

  void onSkipButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Home(
        userEmail: '',
      );
    }));
  }

  void onSignInTextPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return LogInScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Stack(
                        children: [
                          Image.asset(
                            contents[i].image,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ).animate().move(
                                delay: 300.ms,
                                duration: 0.5.seconds,
                              ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.circleArrowRight,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: onSkipButtonPressed,
                            ),
                          )
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          children: [
                            Text(
                              contents[i].title,
                              style: const TextStyle(
                                color: Color(0xFF1C8892),
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    contents[i].discription,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 29, 17, 17),
                                      height: 1.8,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: currentIndex == contents.length - 1
                          ? onGetStartedButtonPressed
                          : onNextButtonPressed,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF1C8892),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                      ),
                      child: Text(
                        currentIndex == contents.length - 1
                            ? "Get Started"
                            : "Next",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return LogInScreen();
                          }));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: const Color(0xFF1C8892),
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index) {
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
