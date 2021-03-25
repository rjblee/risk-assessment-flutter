import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import '../appbar.dart';
import 'mental_wellness_questionnaire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../hazard_category_box.dart';
import '../hazard_dropdown.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class HazardCategory extends StatefulWidget {
  HazardCategory({this.environmentReference});

  final environmentReference;

  @override
  _HazardCategoryState createState() => _HazardCategoryState();
}

class _HazardCategoryState extends State<HazardCategory> {
  Map hazardScore = new Map();
  //{"physical Score": 0,'bil'}

  //int physicalScore = 0;
  //int biologicalScore = 0;
  //int chemicalScore = 0;
  int totalHazardScore = 0;

  static List<Hazard> _hazardList = [];

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
                            'Select all Hazards that Apply',
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
                                print(hazardCategory['hazard_category_name']);
                                hazardCategoryList.add(
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: HazardDropdown(
                                      hazardCategory: hazardCategory['hazard_category_name'],
                                      hazardCategoryReference:
                                          hazardCategory.reference.collection('hazard').snapshots(),
                                    ),
                                  ),
                                );
                              }

                              return Column(
                                children: hazardCategoryList,
                              );
                            } else {
                              // return Text('Snapshot Error');
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
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
            buttonText: 'Next',
            nextWidget: MentalWellnessQuestionnaire(totalHazardScore: totalHazardScore),
          ),
        ],
      ),
    );
  }

  // Hazard Dropdown widget from package
  HazardDropdown({hazardCategory, hazardCategoryReference}) {
    return StreamBuilder<QuerySnapshot>(
      stream: hazardCategoryReference,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final hazards = snapshot.data.docs;

          print(hazards);
          _hazardList = [];
          for (var hazard in hazards) {
            _hazardList.add(
              Hazard(hazardName: hazard['hazard_name'], riskValue: hazard['risk_value']),
            );
          }

          final _items = _hazardList.map((hazard) => MultiSelectItem<Hazard>(hazard, hazard.hazardName)).toList();

          return MultiSelectDialogField(
            items: _items,
            title: Text("$hazardCategory"),
            selectedColor: Colors.black,
            selectedItemsTextStyle: TextStyle(fontSize: 20),
            decoration: BoxDecoration(
              color: kAppLight,
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

              for (var i = 0; i < results.length; i++) {
                hazardScore[hazardCategory] += results[i].riskValue;
              }

              /*
                if (hazardCategory == 'Physical Hazards') {

                 // $hazardCategory
                  physicalScore = 0;

                  for (var i = 0; i < results.length; i++) {
                    physicalScore += results[i].riskValue;
                  }
                } else if (hazardCategory == 'Biological Hazards') {
                  biologicalScore = 0;

                  for (var i = 0; i < results.length; i++) {
                    biologicalScore += results[i].riskValue;
                  }
                } else if (hazardCategory == 'Chemical Hazards') {
                  chemicalScore = 0;

                  for (var i = 0; i < results.length; i++) {
                    chemicalScore += results[i].riskValue;
                  }
                }
                */

              totalHazardScore = 0;
              hazardScore.forEach((key, value) {
                totalHazardScore += value;
              });
              //totalHazardScore = physicalScore + biologicalScore + chemicalScore;

              //print(physicalScore);
              //print(biologicalScore);
              //print(chemicalScore);
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
