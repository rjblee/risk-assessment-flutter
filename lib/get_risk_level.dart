import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

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
            var level = data['level_high'];
            return Text(
              level,
              style: kCombinedResultTextStyle,
            );
          } else if (score <= data['score_low']) {
            var level = data['level_low'];
            return Text(
              level,
              style: kCombinedResultTextStyle,
            );
          } else {
            var level = data['level_medium'];
            return Text(
              level,
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
