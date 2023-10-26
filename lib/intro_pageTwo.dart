import 'package:flutter/material.dart';

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'images/-medical-equipment-img.png',
              height: 360,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Medical Devices !",
            style: TextStyle(
                color: Color(0xFF1C8892),
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
              textAlign: TextAlign.center,
              "Find the best medical devices available for you and explore a wide range of healthcare \nequipment.",
              style: TextStyle(
                  color: Color.fromARGB(255, 95, 94, 94),
                  height: 1.8,
                  fontSize: 16)),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1C8892),
                ),
              ),
              Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1C8892),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF1C8892),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        "Get started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
