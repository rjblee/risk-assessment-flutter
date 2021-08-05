import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../environment_box.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class Environment extends StatefulWidget {
  Environment({this.industryReference});

  // final industryID;
  final industryReference;

  @override
  _EnvironmentState createState() => _EnvironmentState();
}

class _EnvironmentState extends State<Environment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: ListView(
        children: [
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Select your Environment',
                      textAlign: TextAlign.center,
                      style: kHeaderTextStyle,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: widget.industryReference,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final environments = snapshot.data.docs;
                        final List<Widget> environmentList = [];

                        for (var environment in environments) {
                          // print(environment.reference.collection('hazard_category').snapshots());
                          environmentList.add(
                            EnvironmentBox(
                              environmentName: environment['environment_name'],
                              environmentReference: environment.reference.collection('hazard_category').snapshots(),
                            ),
                          );
                        }

                        return Column(
                          children: environmentList,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
