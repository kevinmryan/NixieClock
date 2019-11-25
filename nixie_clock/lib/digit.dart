import 'package:flutter/material.dart';

/// A custom nixie tube digit widget.
class Digit extends StatelessWidget {

  // Initialize
  int digitValue = 0;
  double position = 0.0;

  // Map for digit image assets
  Map assetImagePath = {-1:"assets/off.png",0:"assets/0.png",
    1:"assets/1.png",2:"assets/2.png",
    3:"assets/3.png",4:"assets/4.png",
    5:"assets/5.png",6:"assets/6.png",
    7:"assets/7.png",8:"assets/8.png",
    9:"assets/9.png"};

  // Constructor
  Digit(int digitValue, double position){
    this.digitValue = digitValue;
    this.position = position;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(this.position, 0.0), // horizontal alignment
        child:FractionallySizedBox(
          widthFactor: 0.24, // scale to 24% of parent width
          heightFactor: 1.0, // no height restriction
          child: Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(this.assetImagePath[this.digitValue])
          )
      )
    );
  }
}