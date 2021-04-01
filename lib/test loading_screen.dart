import 'package:flutter/material.dart';
import 'dart:async';

import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:risk_assessment_flutter/test%20result_screen.dart';

import 'screens/result.dart';

// class TestResult extends StatefulWidget {
//   TestResult({this.totalHazardScore, this.totalMentalScore, this.totalCombinedScore});
//
//   final int totalHazardScore;
//   final int totalMentalScore;
//   final int totalCombinedScore;
//
//   @override
//   _TestResultState createState() => _TestResultState();
// }
//
// class _TestResultState extends State<TestResult> {
//   String displayPage = 'loadingScreen';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     // const loadingTime = const Duration(milliseconds: 3000);
//     //
//     // new Timer(loadingTime, () {
//     //   setState(() {
//     //     state = 'resultScreen';
//     //   });
//     //   print("timerrrr");
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const loadingTime = const Duration(milliseconds: 1000);
//
//     new Timer(loadingTime, () {
//       // setState(() {
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return ResultScreen();
//       }));
//       // });
//     });
//     // return displayPage == 'loadingScreen'
//     //     ? LoadingScreen()
//     //     : ResultScreen(
//     //   totalHazard: widget.totalHazardScore,
//     //   totalMental: widget.totalMentalScore,
//     //   totalCombined: widget.totalCombinedScore,
//     // );
//   }
// }

class TestLoadingScreen extends StatefulWidget {
  @override
  _TestLoadingScreenState createState() => _TestLoadingScreenState();
}

class _TestLoadingScreenState extends State<TestLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    // new Timer(Duration(seconds: 2), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => TestResultScreen()));
    // });

    Future.delayed(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
      Navigator.push(context, MaterialPageRoute(builder: (context) => TestResultScreen()));
    });

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
