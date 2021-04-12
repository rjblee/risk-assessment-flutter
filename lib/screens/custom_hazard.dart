import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import '../appbar.dart';
import '../slider_card.dart';
import 'mental_wellness_questionnaire.dart';

class CustomHazard extends StatefulWidget {
  @override
  _CustomHazardState createState() => _CustomHazardState();
}

class _CustomHazardState extends State<CustomHazard> {
  int sliderValue1;
  int sliderValue2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Add a Custom Hazard',
                            textAlign: TextAlign.center,
                            style: kHeaderTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Use the following fields to add a custom hazard to your assessment.',
                            textAlign: TextAlign.center,
                            style: kBodyTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Hazard name',
                            ),
                          ),
                        ),
                        SliderCard(
                          question:
                              "Hazard Severity: How much harm would the hazard cause in the event of an accident?",
                          onChange: (newValue) {
                            sliderValue1 = (newValue.round());
                            print(sliderValue1);

                            // if (wellnessQuestion['question_type'] == "negative") {
                            //   sliderValue[i] = 10 - sliderValue[i];
                            // }
                          },
                        ),
                        SliderCard(
                          question: "Hazard Likelihood: How likely is it that this hazard will result in an accident?",
                          onChange: (newValue) {
                            sliderValue2 = (newValue.round());
                            print(sliderValue2);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(50),
            width: 400,
            child: ElevatedButton(
              child: Text(
                "Add",
                style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // return MentalWellnessQuestionnaire(
                  //   totalHazardScore: totalHazardScore,
                  //   combinedHigh: combinedHigh,
                  //   combinedLow: combinedLow,
                  // );
                }));
              },
              style: ElevatedButton.styleFrom(
                primary: kAppBlue,
                onPrimary: kAppLight,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
              ),
            ),
          ),
          // NextButton(
          //   buttonText: 'Next',
          //   nextWidget: MentalWellnessQuestionnaire(totalHazardScore: totalHazardScore),
          // ),
        ],
      ),
    );
  }
}
