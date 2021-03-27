import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'support.dart';
import '../next_button.dart';

class Result extends StatefulWidget {
  Result({this.totalHazardScore, this.totalMentalScore, this.totalCombinedScore});

  final int totalHazardScore;
  final int totalMentalScore;
  final int totalCombinedScore;

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String state = 'loadingScreen';

  @override
  Widget build(BuildContext context) {
    const loadingTime = const Duration(milliseconds: 3000);

    new Timer(loadingTime, () {
      setState(() {
        state = 'resultScreen';
      });
    });

    return state == 'loadingScreen' ? LoadingScreen() : ResultScreen(totalHazard: widget.totalMentalScore);
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
class ResultScreen extends StatelessWidget {
  ResultScreen({this.totalHazard});

  final totalHazard;

  @override
  Widget build(BuildContext context) {
    var title = "Undetermined";
    // if (totalHazard > 0) {
    //   title = "high";
    // }
    //
    // print(totalHazard);

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
              color: kResultMedium,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'YanoneKaffeesatz'),
                ),
                SizedBox(height: 20),
                Text(
                  'According to your results, you are in a MEDIUM risk environment with a LOW risk mindset.',
                  style: kBodyTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
              color: kAppLight,
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
              color: kAppLight,
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
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: NextButton(buttonText: 'Next'),
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
