import 'package:flutter/material.dart';

// Widget which can set image outside of the screen without overflow
class PositionedImage extends StatelessWidget {
  const PositionedImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Positioned(
              // because it is beyond width
              left: -constraints.maxWidth * .1,
              right: -constraints.maxWidth * .1,

              top: constraints.maxHeight * .7, // you may need to change value
              child: Image.asset(
                "images/WqyOC.png",
                // width: constraints.maxWidth * 1.2, // because it is beyond width
                fit: BoxFit.fitWidth,
              ),
            ),

            ///* your rest widget with Positioned or [Align] widget
          ],
        ),
      ),
    );
  }
}