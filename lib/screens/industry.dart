import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import '../industry_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class Industry extends StatefulWidget {
  @override
  _IndustryState createState() => _IndustryState();
}

class _IndustryState extends State<Industry> {
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
                    final List<Widget> industryList = [];

                    for (var industry in industries) {
                      // print(industry['industry_name']);
                      // print(industry);
                      industryList.add(
                        IndustryBox(
                          industryName: industry['industry_name'],
                          iconImage: industry['icon'],
                          industryReference: industry.reference.collection('environment').orderBy('order').snapshots(),
                        ),
                      );
                    }

                    return Column(
                      children: industryList,
                    );
                  } else {
                    return Text('Snapshot Error');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
