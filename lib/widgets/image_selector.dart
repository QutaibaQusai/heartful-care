import 'package:flutter/material.dart';

class ImageSelectorWidget extends StatelessWidget {
  final String imageUrl;

  const ImageSelectorWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black
                  .withOpacity(0.5), // Change the opacity value as needed
            ),
            Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
