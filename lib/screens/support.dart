import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'environment.dart';
import 'industry.dart';

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: ListView(
        children: [
          // Container(
          //   padding: EdgeInsets.all(20),
          //   child: Text(
          //     'Your Result',
          //     textAlign: TextAlign.center,
          //     style: kHeaderTextStyle,
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.all(10),
          //   padding: EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     color: Colors.yellow[400],
          //   ),
          //   child: Column(
          //     children: [
          //       Text(
          //         'MEDIUM',
          //         style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         'According to your results, you are in a MEDIUM risk environment with a LOW risk mindset.',
          //         style: TextStyle(fontSize: 20),
          //         textAlign: TextAlign.center,
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          // Text(
          //   'Learn to Lower your Risk',
          //   style: kHeaderTextStyle,
          //   textAlign: TextAlign.center,
          // ),
          // Container(
          //   margin: EdgeInsets.all(10),
          //   padding: EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     color: Color(0xFF2f7edb).withOpacity(0.5),
          //   ),
          //   child: Column(
          //     children: [
          //       Text(
          //         'Click Here for our Risk Management Course',
          //         style: kHeaderTextStyle,
          //         textAlign: TextAlign.center,
          //       ),
          //       SizedBox(height: 20),
          //       Text(
          //         'Your score was most influenced by hazards in your environment. Pay close attention to the Module 2 of our course on Identifying and Controlling Hazards.',
          //         style: TextStyle(fontSize: 20),
          //         textAlign: TextAlign.center,
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.all(10),
          //   padding: EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     color: Color(0xFF2f7edb).withOpacity(0.5),
          //   ),
          //   child: Column(
          //     children: [
          //       Text(
          //         'You have the RIGHT and RESPONSIBILITY to refuse unsafe work',
          //         style: kHeaderTextStyle,
          //         textAlign: TextAlign.center,
          //       ),
          //       SizedBox(height: 20),
          //       Text(
          //         'Click here for the rules on workers\' rights in your province or territory.',
          //         style: TextStyle(fontSize: 20),
          //         textAlign: TextAlign.center,
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(50),
            child: ElevatedButton(
              child: Text(
                "Try Again",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Industry();
                }));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[800],
                onPrimary: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
