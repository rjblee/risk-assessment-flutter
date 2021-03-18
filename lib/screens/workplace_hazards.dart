import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import '../appbar.dart';
import 'mental_wellness_questionnaire.dart';
import 'environment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Access a Cloud Firestore instance from your Activity
final _firestore = FirebaseFirestore.instance;

class WorkplaceHazards extends StatefulWidget {
  WorkplaceHazards({this.industryID, this.environmentID});

  final String industryID;
  final String environmentID;

  @override
  _WorkplaceHazardsState createState() => _WorkplaceHazardsState();
}

class _WorkplaceHazardsState extends State<WorkplaceHazards> {
  int physicalScore = 0;
  int biologicalScore = 0;
  int chemicalScore = 0;
  int totalHazardScore = 0;

  static List<Hazard> _hazards = [
    Hazard(id: 1, riskValue: 1, name: "Body stressing"),
    Hazard(id: 2, riskValue: 1, name: "Confined spaces"),
    Hazard(id: 3, riskValue: 1, name: "Electricity"),
    Hazard(id: 4, riskValue: 1, name: "Heat"),
    Hazard(id: 5, riskValue: 1, name: "Cold"),
    Hazard(id: 6, riskValue: 1, name: "Noise"),
    Hazard(id: 7, riskValue: 1, name: "Vibration"),
    Hazard(id: 8, riskValue: 1, name: "Temperature extremes"),
    Hazard(id: 9, riskValue: 1, name: "Radiation"),
    Hazard(id: 10, riskValue: 1, name: "Heights"),
    Hazard(id: 11, riskValue: 1, name: "Viruses"),
    Hazard(id: 12, riskValue: 1, name: "Toxins"),
    Hazard(id: 13, riskValue: 1, name: "Spores"),
    Hazard(id: 14, riskValue: 1, name: "Fungi"),
    Hazard(id: 15, riskValue: 1, name: "Pathogenic micro-organisms"),
    Hazard(id: 16, riskValue: 1, name: "Bio-active substances"),
    Hazard(id: 17, riskValue: 1, name: "Bacteria"),
    Hazard(id: 18, riskValue: 1, name: "Acids"),
    Hazard(id: 19, riskValue: 1, name: "Caustic substances"),
    Hazard(id: 20, riskValue: 1, name: "Cleaning products"),
    Hazard(id: 21, riskValue: 1, name: "Glues"),
    Hazard(id: 22, riskValue: 1, name: "Pesticides"),
    Hazard(id: 23, riskValue: 1, name: "Petroleum products"),
    Hazard(id: 24, riskValue: 1, name: "Mercury"),
    Hazard(id: 25, riskValue: 1, name: "Explosive"),
    Hazard(id: 26, riskValue: 1, name: "Flammable"),
    Hazard(id: 27, riskValue: 1, name: "Corrosive"),
  ];

  final _items = _hazards.map((hazard) => MultiSelectItem<Hazard>(hazard, hazard.name)).toList();

  // List<Hazard> _selectedPhysicalHazards = [];
  // List<Hazard> _selectedBiologicalHazards = [];
  // List<Hazard> _selectedChemicalHazards = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // _selectedHazards5 = _hazards;
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
                            'Select all that Apply',
                            textAlign: TextAlign.center,
                            style: kHeaderTextStyle,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: HazardDropdown('Physical Hazards'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: HazardDropdown('Biological Hazards'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: HazardDropdown('Chemical Hazards'),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('industry')
                              .doc(widget.industryID)
                              .collection('environment')
                              .doc(widget.environmentID)
                              .collection('hazard_category')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final hazardCategories = snapshot.data.docs;
                              // print(environments);
                              final List<Widget> hazardCategoryList = [];

                              for (var hazardCategory in hazardCategories) {
                                print(hazardCategory['hazard_category_name']);
                                // environmentList.add(EnvironmentBox(environmentName: environment['environment_name']));
                              }

                              return Column(
                                  // children: environmentList,
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

  // Extracted Hazard Dropdown widget
  MultiSelectDialogField<Hazard> HazardDropdown(hazardType) {
    return MultiSelectDialogField(
      items: _items,
      title: Text("$hazardType"),
      selectedColor: Colors.black,
      selectedItemsTextStyle: TextStyle(fontSize: 20),
      decoration: BoxDecoration(
        // color: Color(0xFF2f7edb).withOpacity(0.7),
        color: kAppLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // border: Border.all(
        //   // color: Color(0xFF2f7edb),
        //   width: 1,
        // ),
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
        "$hazardType",
        style: kSubHeaderTextStyle,
      ),
      onConfirm: (results) {
        if (hazardType == 'Physical Hazards') {
          physicalScore = 0;

          for (var i = 0; i < results.length; i++) {
            physicalScore += results[i].riskValue;
          }
        } else if (hazardType == 'Biological Hazards') {
          biologicalScore = 0;

          for (var i = 0; i < results.length; i++) {
            biologicalScore += results[i].riskValue;
          }
        } else if (hazardType == 'Chemical Hazards') {
          chemicalScore = 0;

          for (var i = 0; i < results.length; i++) {
            chemicalScore += results[i].riskValue;
          }
        }

        totalHazardScore = physicalScore + biologicalScore + chemicalScore;

        print(physicalScore);
        print(biologicalScore);
        print(chemicalScore);
        print(totalHazardScore);
      },
    );
  }
}

class Hazard {
  Hazard({this.id, this.riskValue, this.name});

  final int id;
  final int riskValue;
  final String name;
}
