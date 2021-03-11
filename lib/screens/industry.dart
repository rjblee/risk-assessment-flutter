import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import '../industry_box.dart';

class Industry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Select your Industry',
                  textAlign: TextAlign.center,
                  style: kHeaderTextStyle,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IndustryBox(
                    industryName: 'Constructions',
                    iconImage: 'Construction placeholder icon.png',
                  ),
                  IndustryBox(
                    industryName: 'Services and Hospitality',
                    iconImage: 'Service Hospitality placeholder icon.png',
                  ),
                  IndustryBox(
                    industryName: 'Other',
                    iconImage: 'Misc placeholder icon.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
