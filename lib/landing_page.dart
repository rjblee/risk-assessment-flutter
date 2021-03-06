import 'package:flutter/material.dart';
import 'appbar.dart';
import 'agreement.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  // Text(
                  //   'SAHARA',
                  //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  // ),
                  // Text(
                  //   'Safety & Hazard Risk Assessment App',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //   ),
                  // ),
                  Image.asset(
                    'images/SAHARA Logo.png',
                    width: 380,
                  ),
                ],
              ),
            ),
            Center(
              child: Image.asset(
                'images/SIS Logo.png',
                width: 240,
              ),
            ),
            FlatButton(
              padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Color(0XFFB5121B),
              textColor: Color(0xFFFFFFFF),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Agreement();
                }));
              },
              child: Text(
                'Enter',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
