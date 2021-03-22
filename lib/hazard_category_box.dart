import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:risk_assessment_flutter/screens/workplace_hazards.dart';

//
// class HazardContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: widget.workplaceHazard,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final hazardCategories = snapshot.data.docs;
//                 // print(environments);
//                 final List<Widget> hazardCategoryList = [];
//
//                 for (var hazardCategory in hazardCategories) {
//                   print(hazardCategory['hazard_category_name']);
//                   hazardCategoryList.add(HazardDropdown(hazardCategory['hazard_category_name']));
//                 }
//
//                 return Column(
//                   children: hazardCategoryList,
//                 );
//               } else {
//                 // return Text('Snapshot Error');
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
