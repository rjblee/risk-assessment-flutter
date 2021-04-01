import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
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

  int totalScore = 0;
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
                                // print(hazardCategory['hazard_category_name']);
                                hazardCategoryList.add(
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: HazardDropdown(
                                        hazardCategory: hazardCategory['hazard_category_name'],
                                        hazardCategoryReference:
                                            hazardCategory.reference.collection('hazard').snapshots(),
                                        callback: (int total) {
                                          totalHazardScore = total;
                                        }),
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
          ElevatedButton(
            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MentalWellnessQuestionnaire(totalHazardScore: totalHazardScore);
              }));
            },
            style: ElevatedButton.styleFrom(
              primary: kAppBlue,
              onPrimary: kAppLight,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
              padding: EdgeInsets.symmetric(vertical: 14),
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
              var totalHazardScore1 = 0;

              for (var i = 0; i < results.length; i++) {
                hazardScore[hazardCategory] += results[i].riskValue;
              }

              hazardScore.forEach((key, value) {
                totalHazardScore1 += value;
              });
              //totalHazardScore = totalHazardScore1;
              callback(totalHazardScore1);
              print(totalHazardScore1);
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
