import 'package:flutter/material.dart';
import 'environment.dart';

class Industry extends StatelessWidget {
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
                  'Select your Industry',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IndustryBox('Constructions'),
                  IndustryBox('Services and Hospitality'),
                  IndustryBox('Other'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
