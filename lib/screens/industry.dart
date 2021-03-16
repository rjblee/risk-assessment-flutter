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
    await for (var snapshot in _firestore.collection("industry").snapshots()) {
      for (var industry in snapshot.docs) {
        print('---------------------------');
        print(industry.data()['name']);
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
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('industry').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final industries = snapshot.data.docs;

                      // print(industries);
                      final List<Widget> boxArray = [];

                      for (var ind in industries) {
                        print(ind['name']);
                        boxArray.add(
                            IndustryBox(industryName: ind['name'], iconImage: 'Construction placeholder icon.png'));
                      }

                      return Column(
                        children: boxArray,
                      );
                    } else {
                      return Text('hello');
                    }
                  })
              /*
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
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('industry').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final industries = snapshot.data.docs;
                        List<Text> industryWidgets = [];
                        for (var industry in industries) {
                          final industryName = industry.data()['name'];
                        }
                      }
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
              */
            ],
          ),
        ),
      ),
    );
  }
}
