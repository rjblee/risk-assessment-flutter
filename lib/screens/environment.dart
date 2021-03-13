import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'workplace_hazards.dart';

class Environment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Select your Environment',
                textAlign: TextAlign.center,
                style: kHeaderTextStyle,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EnvironmentBox('Environment A'),
                EnvironmentBox('Environment B'),
                EnvironmentBox('Environment C'),
                EnvironmentBox('Environment D'),
                EnvironmentBox('Environment E'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EnvironmentBox extends StatelessWidget {
  EnvironmentBox(this.environmentName);

  final String environmentName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Text(
          environmentName,
          style: kSubHeaderTextStyle,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WorkplaceHazards();
          }));
        },
        style: ElevatedButton.styleFrom(
          primary: kAppBlue,
          onPrimary: kAppLight,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
          padding: EdgeInsets.symmetric(vertical: 30),
        ),
      ),
    );
  }
}
