import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
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
  int totalCustomHazardScore = 0;

  static int totalNonCustomHazardScore = 0;
  int totalNonCustomHazardScore1 = 0;
  int totalHazardScore = 0;

  static int combinedHigh;
  static int combinedLow;
  static MultiSelectDialogField customMultiSelectField;
  String documentId = 'xWgXGdtkGY64hClTe4vG';

  static List<Hazard> _hazardList = [];
  static List<Hazard> customHazardList = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  void refresh(newList) {
    setState(() {
      customHazardList = newList;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    customMultiSelectField = MultiSelectDialogField(
      items: customHazardList.map((hazard) => MultiSelectItem<Hazard>(hazard, hazard.hazardName)).toList(),
      title: Text(
        "Custom",
        textAlign: TextAlign.center,
      ),
      selectedColor: kAppBlue,
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
        "Custom",
        style: kSubHeaderTextStyle,
      ),
      onConfirm: (results) {
        totalCustomHazardScore = 0;
        // var totalHazardScore = 0;

        for (var i = 0; i < results.length; i++) {
          totalCustomHazardScore += results[i].riskValue;
        }

        // totalHazardScore += customHazardScore;
        // hazardScore.forEach((key, value) {
        //   totalHazardScore += value;
        // });

        print('custom $totalCustomHazardScore');
        // print('total $totalHazardScore');
      },
    );
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
                                    padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                                    child: HazardDropdown(
                                      hazardCategory: hazardCategory['hazard_category_name'],
                                      hazardCategoryReference:
                                          hazardCategory.reference.collection('hazard').snapshots(),
                                      callback: (int riskValueScore) {
                                        totalNonCustomHazardScore = 0;
                                        totalNonCustomHazardScore = riskValueScore;
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

                        // One-time data read for the Custom hazard category
                        // FutureBuilder<QuerySnapshot>(
                        //   future: _firestore
                        //       .collection('industry') // industry collection
                        //       .doc('2tJSRKm9KG8NMmP7me6MI') // services and hospitality document
                        //       .collection('environment') // environment collection
                        //       .doc('1QVtTPSxgzeLVNw2bu87') // community services document
                        //       .collection('hazard_category') // hazard category collection
                        //       .get(),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasError) {
                        //       return Text("Something went wrong");
                        //     }
                        //
                        //     if (snapshot.hasData) {
                        //       _hazardList = customHazardList;
                        //
                        //       return

                        Container(
                          padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                          child: customMultiSelectField,
                        ),
                        // } else {
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        //   },
                        // ),

                        // FutureBuilder to retrieve the threshold data from backend for result colour
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
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Add Custom Hazard button to setState when finished adding a new custom hazard to bring back the data
          Container(
            padding: EdgeInsets.fromLTRB(50, 50, 50, 25),
            width: 400,
            child: ElevatedButton(
              child: Text(
                "Add Custom Hazard",
                style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
              ),
              onPressed: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CustomHazard();
                }));
                //     .then((value) {
                //   setState(() {
                //     customHazardList = value;
                //   });
                // });
                // refresh(result);
                print("here is the result");
                print(result);
                if (result != null) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("${result.hazardName} added!"),
                      backgroundColor: kAppBlue,
                    ));
                  //setState(() {
                  //multi.

                  //customHazardList = result;
                  //var hazard = result;
                  print(result);

                  customMultiSelectField.items.add(MultiSelectItem<Hazard>(result, result.hazardName));
                  //});
                  // customHazardList = result;

                  // setState(() {
                  //   totalNonCustomHazardScore = 0;
                  //   customHazardList.add(
                  //     Hazard(
                  //       hazardName: '${result[0]}',
                  //       riskValue: result[1],
                  //     ),
                  //   );
                  // });
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
          Container(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
            width: 400,
            child: ElevatedButton(
              child: Text(
                "Next",
                style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
              ),
              onPressed: () {
                // totalHazardScore = 0;

                totalHazardScore = totalNonCustomHazardScore + totalCustomHazardScore;

                print(totalHazardScore);

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
            selectedColor: kAppBlue,
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

              totalNonCustomHazardScore = 0;

              for (var i = 0; i < results.length; i++) {
                hazardScore[hazardCategory] += results[i].riskValue;
              }

              hazardScore.forEach((key, value) {
                totalNonCustomHazardScore += value;
              });
              callback(totalNonCustomHazardScore);
              print('--- $totalNonCustomHazardScore');
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
  Hazard({this.hazardName, this.riskValue});

  final String hazardName;
  final int riskValue;
}

// refresh(){
//   setState(() {
//     customHazardList = result;
//   });
// }
