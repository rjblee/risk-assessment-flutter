import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:risk_assessment_flutter/get_hazard_level.dart';
import 'package:risk_assessment_flutter/get_mental_level.dart';
import '../get_browser.dart';
import '../get_combined_level.dart';
import 'support.dart';
import '../next_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class Result extends StatefulWidget {
  Result({this.totalHazardScore, this.totalMentalScore, this.totalCombinedScore, this.boxColour});

  final int totalHazardScore;
  final int totalMentalScore;
  final totalCombinedScore;
  final boxColour;

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String displayPage = 'loadingScreen';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const loadingTime = const Duration(milliseconds: 2000);

    new Timer(loadingTime, () {
      setState(() {
        displayPage = 'resultScreen';
      });
    });
    return displayPage == 'loadingScreen'
        ? LoadingScreen()
        : ResultScreen(
            totalHazard: widget.totalHazardScore,
            totalMental: widget.totalMentalScore,
            totalCombined: widget.totalCombinedScore,
            boxColour: widget.boxColour,
          );
  }
}

// Loading page with the spinner
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(
              color: kAppBlue,
              size: 120,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Calculating your Risk Level . . .',
              style: kSubHeaderTextStyle,
            )
          ],
        ),
      ),
    );
  }
}

// Result page with risk level
class ResultScreen extends StatefulWidget {
  ResultScreen({this.totalHazard, this.totalMental, this.totalCombined, this.boxColour});

  final totalHazard;
  final totalMental;
  final totalCombined;
  final boxColour;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // Color backgroundColour = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Your Result',
              textAlign: TextAlign.center,
              style: kHeaderTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: widget.boxColour,
              // color: backgroundColour,
            ),
            child: Column(
              children: [
                GetCombinedLevel(
                  score: widget.totalCombined,
                  // documentId: '7nMZhNcHrhRgLDuLiGxR',
                  documentId: 'xWgXGdtkGY64hClTe4vG',
                  // containerColour: widget.boxColour,
                  // onLevelChange: (title) {
                  //   if (title == 'HIGH') {
                  //     backgroundColour = kResultLowColour;
                  //   }
                  // },
                ),
                // Text(
                //   combinedLevel,
                //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'YanoneKaffeesatz'),
                // ),
                SizedBox(height: 20),
                GetHazardLevel(
                  score: widget.totalHazard,
                  // documentId: '8PdeB25takICLEdsaqEz',
                  documentId: 'syndQC1XUgc7Q9nsbRf3',
                ),
                GetMentalLevel(
                  score: widget.totalMental,
                  // documentId: 'B7EsnmghApXWecsXICl8',
                  documentId: 'yyoraqFyMrBKZMlT8Nvq',
                ),
                // Text(
                //   'According to your results, you are in a $hazardLevel risk environment with a $hazardLevel risk mindset.',
                //   style: kBodyTextStyle,
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            'Learn to Lower your Risk',
            style: kSubHeaderTextStyle,
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  'Click Here for our \nRisk Management Course',
                  style: kSubHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Your score was most influenced by hazards in your environment. Pay close attention to the Module 2 of our course on Identifying and Controlling Hazards.',
                  style: kBodyTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    "Load Course",
                    style: kBodyTextStyle,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Courses(contentID: 445, resumeSession: true);
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kAppBlue,
                    onPrimary: kAppLight,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  'You have the \nRIGHT and RESPONSIBILITY \nto refuse unsafe work',
                  style: kSubHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Click here for the rules on workers\' rights in your province or territory.',
                  style: kBodyTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    "Button",
                    style: kBodyTextStyle,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return GetBrowser('https://swiftlearning.com/#!/home');
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kAppBlue,
                    onPrimary: kAppLight,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: NextButton(
              buttonText: 'Next',
              nextWidget: Support(),
            ),
            // child: ElevatedButton(
            //   child: Text(
            //     "Finish",
            //     style: TextStyle(fontSize: 20),
            //   ),
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return Support();
            //     }));
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.blue[800],
            //     onPrimary: Colors.white,
            //     elevation: 10,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25.0),
            //     ),
            //     padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
