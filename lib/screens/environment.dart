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
      body: Container(
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
                    // print(environments);
                    final List<Widget> environmentList = [];

                    for (var environment in environments) {
                      // print(environment['environment_name']);
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
                    // return Text('Snapshot Error');
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )

              // -------------------ORIGINAL HARD-CODED STUFF-------------------
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     EnvironmentBox('Community Services'),
              //     EnvironmentBox('Restaurant and Food Preparation'),
              //     EnvironmentBox('Hotel'),
              //     EnvironmentBox('Home Services'),
              //     EnvironmentBox('Transportation'),
              //   ],
              // ),
              // -------------------ORIGINAL STUFF-------------------
            ],
          ),
        ),
      ),
    );
  }
}
