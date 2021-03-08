import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'environment.dart';
import 'dart:async';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String state = 'state1';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const loadingTime = const Duration(milliseconds: 2500);

    new Timer(
        loadingTime,
        () => {
              setState(() {
                state = 'state2';
              })
            });

    return state == 'state1' ? LoadingScreen() : ResultScreen();
  }
}

class IndustryBox extends StatelessWidget {
  IndustryBox(this.industryName);

  final String industryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // color: Color(0XFFB5121B),
        color: Color(0XFF3F51B5),
        textColor: Color(0xFFFFFFFF),
        // splashColor: Colors.grey,
        elevation: 10,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Environment();
          }));
        },
        child: Text(
          industryName,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Loading..."),
    );
  }
}

class ResultScreen extends StatelessWidget {
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
                  'Your Result',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IndustryBox('Medium'),
                  IndustryBox('Click here for more information'),
                  IndustryBox('Resources'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
