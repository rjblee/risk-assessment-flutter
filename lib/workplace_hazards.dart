import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'appbar.dart';

class WorkplaceHazards extends StatefulWidget {
  @override
  _WorkplaceHazardsState createState() => _WorkplaceHazardsState();
}

class _WorkplaceHazardsState extends State<WorkplaceHazards> {
  static List<Hazard> _hazards = [
    Hazard(id: 1, name: "Body stressing"),
    Hazard(id: 2, name: "Confined spaces"),
    Hazard(id: 3, name: "Electricity"),
    Hazard(id: 4, name: "Heat"),
    Hazard(id: 5, name: "Cold"),
    Hazard(id: 6, name: "Noise"),
    Hazard(id: 7, name: "Vibration"),
    Hazard(id: 8, name: "Temperature extremes"),
    Hazard(id: 9, name: "Radiation"),
    Hazard(id: 10, name: "Heights"),
    Hazard(id: 11, name: "Viruses"),
    Hazard(id: 12, name: "Toxins"),
    Hazard(id: 13, name: "Spores"),
    Hazard(id: 14, name: "Fungi"),
    Hazard(id: 15, name: "Pathogenic micro-organisms"),
    Hazard(id: 16, name: "Bio-active substances"),
    Hazard(id: 17, name: "Bacteria"),
    Hazard(id: 18, name: "Acids"),
    Hazard(id: 19, name: "Caustic substances"),
    Hazard(id: 20, name: "Cleaning products"),
    Hazard(id: 21, name: "Glues"),
    Hazard(id: 22, name: "Pesticides"),
    Hazard(id: 23, name: "Petroleum products"),
    Hazard(id: 24, name: "Mercury"),
    Hazard(id: 25, name: "Explosive"),
    Hazard(id: 26, name: "Flammable"),
    Hazard(id: 27, name: "Corrosive"),
  ];

  final _items = _hazards.map((hazard) => MultiSelectItem<Hazard>(hazard, hazard.name)).toList();

  List<Hazard> _selectedHazards = [];
  List<Hazard> _selectedHazards2 = [];
  List<Hazard> _selectedHazards3 = [];
  List<Hazard> _selectedHazards4 = [];
  List<Hazard> _selectedHazards5 = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedHazards5 = _hazards;
    super.initState();
  }

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
                  'Select all that Apply',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: HazardDropdown('Physical Hazards'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: HazardDropdown('Biological Hazards'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: HazardDropdown('Chemical Hazards'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Extracted Hazard Dropdown widget
  MultiSelectDialogField<Hazard> HazardDropdown(hazardType) {
    return MultiSelectDialogField(
      items: _items,
      title: Text("$hazardType"),
      selectedColor: Colors.green,
      selectedItemsTextStyle: TextStyle(fontSize: 20),
      decoration: BoxDecoration(
        color: Color(0xFF2f7edb).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(14)),
        // border: Border.all(
        //   color: Color(0xFF2f7edb),
        //   width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      buttonText: Text(
        "$hazardType",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      onConfirm: (results) {
        _selectedHazards = results;
      },
    );
  }
}

class Hazard {
  Hazard({this.id, this.name});

  final int id;
  final String name;
}
