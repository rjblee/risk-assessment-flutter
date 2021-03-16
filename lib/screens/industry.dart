import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import '../industry_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class Industry extends StatefulWidget {
  // Access a Cloud Firestore instance from your Activity
  // FirebaseFirestore db = FirebaseFirestore.getInstance();

  @override
  _IndustryState createState() => _IndustryState();
}

class _IndustryState extends State<Industry> {
  void industriesStream() async {
    await for (var snapshot in _firestore.collection('welding').snapshots()) {
      for (var industry in snapshot.docs) {
        print(industry.data());
      }
    }
  }

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
                  ElevatedButton(
                    child: Text('Test'),
                    onPressed: () {
                      industriesStream();
                    },
                  ),
                  IndustryBox(
                    industryName: 'Welding',
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
