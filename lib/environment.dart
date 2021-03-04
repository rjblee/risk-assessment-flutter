import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/industry.dart';
import 'workplace_hazards.dart';

class Environment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'images/SIS Logo.png',
            width: 240,
          ),
        ),
      ),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EnvironmentBox('Environment A'),
                  EnvironmentBox('Environment B'),
                  EnvironmentBox('Environment C'),
                  EnvironmentBox('Environment D'),
                  EnvironmentBox('Environment E'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnvironmentBox extends StatelessWidget {
  EnvironmentBox(this.environmentName);

  final String environmentName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // color: Color(0XFF3F51B5),
        color: Colors.blue[200],
        // textColor: Color(0xFFFFFFFF),
        // splashColor: Colors.grey,
        elevation: 10,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WorkplaceHazards();
          }));
        },
        child: Text(
          environmentName,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
