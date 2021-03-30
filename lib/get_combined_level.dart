import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

String combinedLevel;

class GetRiskLevel extends StatelessWidget {
  GetRiskLevel({this.totalHazard, this.totalMental, this.totalCombined, this.score, this.documentId});

  final totalHazard;
  final totalMental;
  final totalCombined;
  final score;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('risk_level').doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData) {
          var data = snapshot.data.data();

          if (score >= data['score_high']) {
            combinedLevel = data['level_high'];
            return Text(
              combinedLevel,
              style: kCombinedResultTextStyle,
            );
          } else if (score <= data['score_low']) {
            combinedLevel = data['level_low'];
            return Text(
              combinedLevel,
              style: kCombinedResultTextStyle,
            );
          } else {
            combinedLevel = data['level_medium'];
            return Text(
              combinedLevel,
              style: kCombinedResultTextStyle,
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
