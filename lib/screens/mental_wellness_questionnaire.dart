import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'result.dart';
import 'package:risk_assessment_flutter/slider_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class MentalWellnessQuestionnaire extends StatefulWidget {
  MentalWellnessQuestionnaire({this.totalHazardScore});

  final totalHazardScore;

  @override
  _MentalWellnessQuestionnaireState createState() => _MentalWellnessQuestionnaireState();
}

class _MentalWellnessQuestionnaireState extends State<MentalWellnessQuestionnaire> {
  var sliderValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Mental Wellness Evaluation',
                textAlign: TextAlign.center,
                style: kHeaderTextStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Use the slider to answer how much you agree/disagree to each given question at this moment.',
                textAlign: TextAlign.center,
                style: kBodyTextStyle,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('wellness_question').orderBy('order').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final wellnessQuestions = snapshot.data.docs;
                        final List<Widget> wellnessQuestionList = [];
                        sliderValue = new List<int>.filled(wellnessQuestions.length, 5);

                        for (var i = 0; i < wellnessQuestions.length; i++) {
                          var wellnessQuestion = wellnessQuestions[i];

                          wellnessQuestionList.add(
                            SliderCard(
                              question: wellnessQuestion['question'],
                              onChange: (newValue) {
                                sliderValue[i] = (newValue.round());

                                if (wellnessQuestion['question_type'] == "negative") {
                                  sliderValue[i] = 10 - sliderValue[i];
                                }
                              },
                            ),
                          );
                        }

                        return Column(
                          children: wellnessQuestionList,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  // SliderCard(
                  //   question: 'I feel well-rested and able to focus on the task at hand',
                  //   //sliderValue: sliderValue1,
                  //   onChange: (newValue) {
                  //     sliderValue1 = newValue.round();
                  //   },
                  // ),
                  // SliderCard(
                  //   question: 'I feel supported at work and comfortable asking for help',
                  //   //sliderValue: sliderValue2,
                  //   onChange: (newValue) {
                  //     sliderValue2 = newValue.round();
                  //   },
                  // ),

                  Container(
                    padding: EdgeInsets.all(50),
                    child: ElevatedButton(
                      child: Text(
                        "Finish",
                        style: kSubHeaderTextStyle,
                      ),
                      onPressed: () {
                        print("Hazard Score from mental page:");
                        print(widget.totalHazardScore);

                        var totalMentalScore = 0;

                        for (var x = 0; x < sliderValue.length; x++) {
                          totalMentalScore += sliderValue[x];
                        }
                        print("Mental Score from mental page:");
                        print(totalMentalScore);

                        var totalCombinedScore = widget.totalHazardScore * totalMentalScore;

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Result(
                              totalHazardScore: widget.totalHazardScore,
                              totalMentalScore: totalMentalScore,
                              totalCombinedScore: totalCombinedScore,
                            );
                          },
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kAppBlue,
                        onPrimary: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
