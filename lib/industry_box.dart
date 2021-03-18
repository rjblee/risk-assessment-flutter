import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'screens/environment.dart';

class IndustryBox extends StatelessWidget {
  IndustryBox({this.industryName, this.industryID, this.iconImage, this.environment});

  final String industryName;
  final String iconImage;
  final String industryID;
  final Stream<QuerySnapshot> environment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.asset('images/$iconImage', width: 50),
            ),
            Expanded(
              child: Text(
                industryName,
                style: kSubHeaderTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Environment(industryID: industryID, environment: environment);
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
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
