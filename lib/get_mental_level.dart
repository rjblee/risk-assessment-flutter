import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

String mentalLevel;

class GetMentalLevel extends StatelessWidget {
  GetMentalLevel({this.score, this.documentId});

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
            mentalLevel = data['level_high'];
            return Text(
              'with a $mentalLevel risk mindset.',
              style: kBodyTextStyle,
            );
          } else if (score <= data['score_low']) {
            mentalLevel = data['level_low'];
            return Text(
              'with a $mentalLevel risk mindset.',
              style: kBodyTextStyle,
            );
          } else {
            mentalLevel = data['level_medium'];
            return Text(
              'with a $mentalLevel risk mindset.',
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
