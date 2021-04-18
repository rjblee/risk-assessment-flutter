import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import '../appbar.dart';
import '../custom_slider_card.dart';
import 'hazard_category.dart';

class CustomHazard extends StatefulWidget {
  @override
  _CustomHazardState createState() => _CustomHazardState();
}

class _CustomHazardState extends State<CustomHazard> {
  int sliderValue1 = 1;
  int sliderValue2 = 1;
  final myController = TextEditingController();
  String typedInput;
  static List<Hazard> customHazardList = [];

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
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: myController,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              border: UnderlineInputBorder(),
                              hintText: 'Add your Hazard',
                            ),
                          ),
                        ),
                        CustomSliderCard(
                          question:
                              "Hazard Severity: How much harm would the hazard cause in the event of an accident?",
                          onChange: (newValue) {
                            sliderValue1 = (newValue.round());
                            print(sliderValue1);
                          },
                        ),
                        CustomSliderCard(
                          question: "Hazard Likelihood: How likely is it that this hazard will result in an accident?",
                          onChange: (newValue) {
                            sliderValue2 = (newValue.round());
                            print(sliderValue2);
                          },
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
                              typedInput = myController.text;
                              print(typedInput);
                              customHazardList.add(Hazard(hazardName: typedInput));

                              var customHazardSum = sliderValue1 + sliderValue2;
                              print("Custom sum = $customHazardSum");
                              if (customHazardSum >= 8) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => _buildPopup(context),
                                );
                              } else {
                                // Navigator.of(context).pop();
                                Navigator.pop(context, typedInput);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: kAppBlue,
                              // onPrimary: kAppLight,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPopup(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'WARNING \nUNACCEPTABLE RISK LEVEL',
      textAlign: TextAlign.center,
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "The hazard you have entered has a risk level that is too high to be allowed in a normal working environment. Remember, you have the RIGHT and RESPONSIBILITY to refuse unsafe work.",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Hazards severity and likelihood can be controlled with personal protective equipment, engineered controls, and training and procedures. Contact your supervisor to find acceptable methods to reduce the risk of this hazard before continuing work.",
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
