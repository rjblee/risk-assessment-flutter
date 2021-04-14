import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import 'package:risk_assessment_flutter/screens/custom_hazard.dart';
import '../appbar.dart';
import 'mental_wellness_questionnaire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class HazardCategory extends StatefulWidget {
  HazardCategory({this.environmentReference});

  final environmentReference;

  @override
  _HazardCategoryState createState() => _HazardCategoryState();
}

class _HazardCategoryState extends State<HazardCategory> {
  //{"physical Score": 0,'bil'}
  Map hazardScore = new Map();

  static int totalHazardScore = 0;
  static int combinedHigh;
  static int combinedLow;
  String documentId = 'xWgXGdtkGY64hClTe4vG';

  int totalScore = 0;
  static List<Hazard> _hazardList = [];
  static List<Hazard> _customHazardList = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

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
                            'Select Hazards',
                            textAlign: TextAlign.center,
                            style: kHeaderTextStyle,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: widget.environmentReference,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final hazardCategories = snapshot.data.docs;

                              final List<Widget> hazardCategoryList = [];

                              for (var hazardCategory in hazardCategories) {
                                hazardCategoryList.add(
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: HazardDropdown(
                                      hazardCategory: hazardCategory['hazard_category_name'],
                                      hazardCategoryReference:
                                          hazardCategory.reference.collection('hazard').snapshots(),
                                      callback: (int total) {
                                        totalHazardScore = total;
                                      },
                                    ),
                                  ),
                                );
                              }

                              return Column(
                                children: hazardCategoryList,
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: _firestore.collection('risk_level').doc(documentId).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.hasData) {
                              var data = snapshot.data.data();
                              combinedHigh = data['score_high'];
                              combinedLow = data['score_low'];
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Text("");
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          NextButton(
            buttonText: 'Add Custom Hazard',
            nextWidget: CustomHazard(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
            width: 400,
            child: ElevatedButton(
              child: Text(
                "Next",
                style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MentalWellnessQuestionnaire(
                    totalHazardScore: totalHazardScore,
                    combinedHigh: combinedHigh,
                    combinedLow: combinedLow,
                  );
                }));
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
    );
  }

  // Hazard Dropdown widget from package
  HazardDropdown({hazardCategory, hazardCategoryReference, callback}) {
    return StreamBuilder<QuerySnapshot>(
      stream: hazardCategoryReference,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final hazards = snapshot.data.docs;

          _hazardList = [];
          for (var hazard in hazards) {
            _hazardList.add(
              Hazard(
                hazardName: hazard['hazard_name'],
                riskValue: hazard['risk_value'],
              ),
            );
          }

          final _items = _hazardList.map((hazard) => MultiSelectItem<Hazard>(hazard, hazard.hazardName)).toList();

          return MultiSelectDialogField(
            items: _items,
            title: Text(
              "$hazardCategory",
              textAlign: TextAlign.center,
            ),
            selectedColor: Colors.black,
            selectedItemsTextStyle: TextStyle(fontSize: 20),
            decoration: BoxDecoration(
              // color: kAppLight,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            buttonText: Text(
              "$hazardCategory",
              style: kSubHeaderTextStyle,
            ),
            onConfirm: (results) {
              hazardScore[hazardCategory] = 0;
              var totalHazardScore = 0;

              for (var i = 0; i < results.length; i++) {
                hazardScore[hazardCategory] += results[i].riskValue;
              }

              hazardScore.forEach((key, value) {
                totalHazardScore += value;
              });
              callback(totalHazardScore);
              print(totalHazardScore);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// Hazard constructor
class Hazard {
  Hazard({this.riskValue, this.hazardName});

  final String hazardName;
  final int riskValue;
}
