import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

String combinedLevel;

class GetCombinedLevel extends StatefulWidget {
  GetCombinedLevel({this.score, this.documentId});

  final score;
  final String documentId;

  @override
  _GetCombinedLevelState createState() => _GetCombinedLevelState();
}

class _GetCombinedLevelState extends State<GetCombinedLevel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('risk_level').doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData) {
          var data = snapshot.data.data();

          if (widget.score >= data['score_high']) {
            combinedLevel = data['level_high'];

            return Text(
              combinedLevel,
              style: kCombinedResultTextStyle,
            );
          } else if (widget.score <= data['score_low']) {
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
