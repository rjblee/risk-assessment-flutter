import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/screens/hazard_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnvironmentBox extends StatelessWidget {
  EnvironmentBox({this.environmentName, this.environmentReference});

  final String environmentName;
  final Stream<QuerySnapshot> environmentReference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Row(
          children: [
            Expanded(
              child: Text(
                environmentName,
                style: kSubHeaderTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HazardCategory(environmentReference: environmentReference);
          }));
        },
        style: ElevatedButton.styleFrom(
          primary: kAppBlue,
          onPrimary: kAppLight,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 30),
        ),
      ),
    );
  }
}
