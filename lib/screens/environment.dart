import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'workplace_hazards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class Environment extends StatefulWidget {
  Environment({this.industryID, this.environment});

  final industryID;
  final environment;

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
                stream: widget.environment,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final environments = snapshot.data.docs;
                    // print(environments);
                    final List<Widget> environmentList = [];

                    for (var environment in environments) {
                      // print(environment['environment_name']);
                      // print(environment.reference.collection('hazard_category').snapshots());
                      environmentList.add(EnvironmentBox(
                          environmentName: environment['environment_name'],
                          workplaceHazard: environment.reference.collection('hazard_category').snapshots()));
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

              // -------------------ORIGINAL STUFF-------------------
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

class EnvironmentBox extends StatelessWidget {
  EnvironmentBox({this.environmentName, this.environmentID, this.workplaceHazard});

  final String environmentName;
  final String environmentID;
  final Stream<QuerySnapshot> workplaceHazard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Row(
          children: [
            Expanded(
              child: Text(
                environmentName,
                style: kSubHeaderTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            // return WorkplaceHazards(environmentID: environmentID, workplaceHazard: workplaceHazard);
            return WorkplaceHazards(environmentID: environmentID);
          }));
        },
        style: ElevatedButton.styleFrom(
          primary: kAppBlue,
          onPrimary: kAppLight,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
          padding: EdgeInsets.symmetric(vertical: 30),
        ),
      ),
    );
  }
}
