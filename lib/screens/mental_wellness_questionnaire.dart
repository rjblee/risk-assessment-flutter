import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import '../next_button.dart';
import 'result.dart';
import 'package:risk_assessment_flutter/slider_card.dart';

class MentalWellnessQuestionnaire extends StatefulWidget {
  MentalWellnessQuestionnaire({this.totalHazardScore});

  final int totalHazardScore;

  @override
  _MentalWellnessQuestionnaireState createState() => _MentalWellnessQuestionnaireState();
}

class _MentalWellnessQuestionnaireState extends State<MentalWellnessQuestionnaire> {
  int sliderValue1 = 5;
  int sliderValue2 = 5;
  int sliderValue3 = 5;

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
                  SliderCard(
                    colour: Color(0xFF2f7edb).withOpacity(0.5),
                    question:
                        'I got enough sleep last night and feel well rested enough to do this job to the best of my abilities',
                    //sliderValue: sliderValue1,
                    onChange: (newValue) {
                      sliderValue1 = newValue.round();
                    },
                  ),
                  SliderCard(
                    colour: Color(0xFF2f7edb).withOpacity(0.5),
                    question: 'I have other things I am \nconcerned about',
                    //sliderValue: sliderValue2,
                    onChange: (newValue) {
                      sliderValue2 = newValue.round();
                    },
                  ),
                  SliderCard(
                    colour: Color(0xFF2f7edb).withOpacity(0.5),
                    question: 'My current mood',
                    //sliderValue: sliderValue3,
                    onChange: (newValue) {
                      sliderValue3 = newValue.round();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(50),
                    child: ElevatedButton(
                      child: Text(
                        "Finish",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        print(sliderValue1);
                        print(sliderValue2);
                        print(sliderValue3);
                        print(widget.totalHazardScore);
                        var totalMentalScore = sliderValue1 + sliderValue2 + sliderValue3;
                        print(totalMentalScore);
                        var totalCombinedScore = widget.totalHazardScore + totalMentalScore;
                        print(totalCombinedScore);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Result(
                            totalHazardScore: widget.totalHazardScore,
                            totalMentalScore: totalMentalScore,
                            totalCombinedScore: totalCombinedScore,
                          );
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
