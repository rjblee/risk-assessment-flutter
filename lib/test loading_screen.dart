import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/hazard_category.dart';

//
// HazardDropdown({hazardCategory, hazardCategoryReference}) {
//   return StreamBuilder<QuerySnapshot>(
//       stream: hazardCategoryReference,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final hazards = snapshot.data.docs;
//
//           print(hazards);
//           _hazardList = [];
//           for (var hazard in hazards) {
//             _hazardList.add(
//               Hazard(hazardName: hazard['hazard_name'], riskValue: hazard['risk_value']),
//             );
//           }
//
//           final _items = _hazardList.map((hazard) => MultiSelectItem<Hazard>(hazard, hazard.hazardName)).toList();
//
//           return MultiSelectDialogField(
//             items: _items,
//             title: Text("$hazardCategory"),
//             selectedColor: Colors.black,
//             selectedItemsTextStyle: TextStyle(fontSize: 20),
//             decoration: BoxDecoration(
//               color: kAppLight,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.6),
//                   spreadRadius: 4,
//                   blurRadius: 4,
//                   offset: Offset(0, 4), // changes position of shadow
//                 ),
//               ],
//             ),
//             buttonText: Text(
//               "$hazardCategory",
//               style: kSubHeaderTextStyle,
//             ),
//             onConfirm: (results) {
//               if (hazardCategory == 'Physical Hazards') {
//                 physicalScore = 0;
//
//                 for (var i = 0; i < results.length; i++) {
//                   physicalScore += results[i].riskValue;
//                 }
//               } else if (hazardCategory == 'Biological Hazards') {
//                 biologicalScore = 0;
//
//                 for (var i = 0; i < results.length; i++) {
//                   biologicalScore += results[i].riskValue;
//                 }
//               } else if (hazardCategory == 'Chemical Hazards') {
//                 chemicalScore = 0;
//
//                 for (var i = 0; i < results.length; i++) {
//                   chemicalScore += results[i].riskValue;
//                 }
//               }
//
//               totalHazardScore = physicalScore + biologicalScore + chemicalScore;
//
//               print(physicalScore);
//               print(biologicalScore);
//               print(chemicalScore);
//               print(totalHazardScore);
//             },
//           );
//         } else {
//           return Text('HH');
//         }
//       });
// }
