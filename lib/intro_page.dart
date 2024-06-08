import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test/home.dart';
import 'package:test/model/Intro_Model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/User%20login-Sginup/login_screen.dart';
import 'package:test/provider/myprovider.dart';

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

    // check the saved user data.
    context.read<MyProvider>().GetUserlogin().then(
      (data) {
        print("is this empty  :${data.isEmpty} ");

        if (data.isNotEmpty) {
          print("there is data found :${data[0]} ");

          Navigator.push(
            context,
            PageTransition(
                child: Home(userEmail: data[0]),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500)),
          );
        } else {
          print("there is no data saved!");
        }
      },
    );
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                              width: screenWidth,
                              height: screenHeight * 0.5,
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
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          children: [
                            Text(
                              contents[i].title,
                              style: TextStyle(
                                color: Color(0xFF1C8892),
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              contents[i].discription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 29, 17, 17),
                                height: 1.8,
                                fontSize: screenWidth * 0.04,
                              ),
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
                (index) => buildDot(index, screenWidth),
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
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: onSignInTextPressed,
                        child: Flexible(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: const Color(0xFF1C8892),
                              fontSize: screenWidth * 0.04,
                              decoration: TextDecoration.underline,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
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

  Container buildDot(int index, double screenWidth) {
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
