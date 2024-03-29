import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/get_combined_level.dart';
import 'result.dart';
import 'package:risk_assessment_flutter/slider_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class MentalWellnessQuestionnaire extends StatefulWidget {
  MentalWellnessQuestionnaire({this.totalHazardScore, this.combinedHigh, this.combinedLow}) {
    print('totalHazardScore = ' + this.totalHazardScore.toString());
    print('combinedHigh = ' + this.combinedHigh.toString());
    print('combinedLow = ' + this.combinedLow.toString());
  }

  final int totalHazardScore;
  final int combinedHigh;
  final int combinedLow;

  @override
  _MentalWellnessQuestionnaireState createState() => _MentalWellnessQuestionnaireState();
}

class _MentalWellnessQuestionnaireState extends State<MentalWellnessQuestionnaire> {
  var sliderValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: ListView(
        children: [
          Column(
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
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('wellness_question').orderBy('order').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final wellnessQuestions = snapshot.data.docs;
                    final List<Widget> wellnessQuestionList = [];
                    sliderValue =
                        new List<int>.filled(wellnessQuestions.length, 5); // sliderValue is "filled" with value 5

                    for (var i = 0; i < wellnessQuestions.length; i++) {
                      var wellnessQuestion = wellnessQuestions[i];

                      wellnessQuestionList.add(
                        SliderCard(
                          question: wellnessQuestion['question'],
                          onChange: (newValue) {
                            sliderValue[i] = (newValue.round());

                            // For the negative type of questions, the higher sliderValue will be a low value
                            if (wellnessQuestion['question_type'] == "positive") {
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
              Container(
                padding: EdgeInsets.all(50),
                width: 400,
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

                    double compoundingFactor;

                    if (totalMentalScore <= 12) {
                      compoundingFactor = 1;
                    } else if (totalMentalScore >= 26) {
                      compoundingFactor = 2;
                    } else {
                      compoundingFactor = 1.5;
                    }

                    print("Compounding factor: ");
                    print(compoundingFactor);

                    double totalCombinedScore = widget.totalHazardScore * compoundingFactor;

                    print("Total Combined Score: ");
                    print(totalCombinedScore);

                    var boxColour;

                    // Determine the result section background colour by comparing the threshold values from the backend
                    if (totalCombinedScore >= widget.combinedHigh) {
                      boxColour = kResultHighColour;
                    } else if (totalCombinedScore > widget.combinedLow) {
                      boxColour = kResultMediumColour;
                    } else {
                      boxColour = kResultLowColour;
                    }

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Result(
                          totalHazardScore: widget.totalHazardScore,
                          totalMentalScore: totalMentalScore,
                          totalCombinedScore: totalCombinedScore,
                          boxColour: boxColour,
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
        ],
      ),
    );
  }
}
