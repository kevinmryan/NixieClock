import 'package:flutter/material.dart';

/// A custom nixie tube colon widget
class Colon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0.0, 1.0), // bottom center align
        child: FractionallySizedBox(
          widthFactor: 0.1, // scale to 10% parent width
          heightFactor: 0.5, // scale to 50% parent height
          child: Container(
            alignment: Alignment.center, // center align
            child:
                Image.asset("assets/colon.jpeg"),
          )
      )
    );
  }
}