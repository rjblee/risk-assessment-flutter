import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

String hazardLevel;

class GetHazardLevel extends StatelessWidget {
  GetHazardLevel({this.score, this.documentId});

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
          // print(score);
          if (score >= data['score_high']) {
            hazardLevel = data['level_high'];

            return Text(
              'You are in a $hazardLevel risk environment ',
              style: kBodyTextStyle,
            );
          } else if (score <= data['score_low']) {
            hazardLevel = data['level_low'];
            print(score);
            return Text(
              'You are in a $hazardLevel risk environment ',
              style: kBodyTextStyle,
            );
          } else {
            hazardLevel = data['level_medium'];
            return Text(
              'You are in a $hazardLevel risk environment ',
              style: kBodyTextStyle,
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
