import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import '../appbar.dart';
import 'agreement.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Image.asset(
                  'images/Sahara Placeholder Logo Square New.png',
                  width: 340,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                Text(
                  'Powered by',
                  style: kSubHeaderTextStyle,
                ),
                SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'images/SIS Logo.png',
                    width: 240,
                  ),
                ),
              ],
            ),
          ),
          NextButton(
            buttonText: 'Get Started',
            nextWidget: Agreement(),
          ),
        ],
      ),
    );
  }
}
