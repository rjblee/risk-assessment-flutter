import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'environment.dart';

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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IndustryBox('Constructions'),
                  IndustryBox('Services and Hospitality'),
                  IndustryBox('Other'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
