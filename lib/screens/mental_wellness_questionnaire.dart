import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'result.dart';
import 'package:risk_assessment_flutter/slider_card.dart';

class MentalWellnessQuestionnaire extends StatefulWidget {
  @override
  _MentalWellnessQuestionnaireState createState() => _MentalWellnessQuestionnaireState();
}

class _MentalWellnessQuestionnaireState extends State<MentalWellnessQuestionnaire> {
  int sliderValue1 = 5;
  int sliderValue2 = 5;
  int sliderValue3 = 5;
  int sliderValue4 = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Mental Wellness Evaluation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Use the slider to answer how much you agree/disagree to each given question at this moment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    SliderCard(
                      colour: Color(0xFF2f7edb).withOpacity(0.5),
                      cardChild: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'I got enough sleep last night and feel well rested enough to do this job to the best of my abilities',
                              style: kHeaderTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // SizedBox(
                          //   height: 4,
                          // ),
                          // Text(
                          //   sliderValue1.toString(),
                          //   style: kSliderNumberStyle,
                          // ),
                          Slider(
                            value: sliderValue1.toDouble(),
                            min: 0,
                            max: 10,
                            activeColor: kSISColour,
                            // inactiveColor: kSISColour.withOpacity(0.2),
                            inactiveColor: Color(0XFF8D8E98),
                            onChanged: (double newValue) {
                              setState(() {
                                sliderValue1 = newValue.round();
                                print(sliderValue1);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SliderCard(
                      colour: Color(0xFF2f7edb).withOpacity(0.5),
                      cardChild: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'I have other things I am \nconcerned about',
                              style: kHeaderTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // SizedBox(
                          //   height: 14,
                          // ),
                          Text(
                            sliderValue2.toString(),
                            style: kSliderNumberStyle,
                          ),
                          Slider(
                            value: sliderValue2.toDouble(),
                            min: 0,
                            max: 10,
                            activeColor: kSISColour,
                            // inactiveColor: kSISColour.withOpacity(0.2),
                            inactiveColor: Color(0XFF8D8E98),
                            onChanged: (double newValue) {
                              setState(() {
                                sliderValue2 = newValue.round();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SliderCard(
                      colour: Color(0xFF2f7edb).withOpacity(0.5),
                      cardChild: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'My current mood',
                              style: kHeaderTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // SizedBox(
                          //   height: 14,
                          // ),
                          Text(
                            sliderValue3.toString(),
                            style: kSliderNumberStyle,
                          ),
                          Slider(
                            value: sliderValue3.toDouble(),
                            min: 0,
                            max: 10,
                            activeColor: kSISColour,
                            // inactiveColor: kSISColour.withOpacity(0.2),
                            inactiveColor: Color(0XFF8D8E98),
                            onChanged: (double newValue) {
                              setState(() {
                                sliderValue3 = newValue.round();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(50),
                      child: ElevatedButton(
                        child: Text(
                          "Finish",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Result();
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
      ),
    );
  }
}
