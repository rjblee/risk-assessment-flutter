import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings =
        const Settings(host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAHARA',
      theme: ThemeData(
        // primaryColor: Color(0XFFB5121B),
        primaryColor: kAppGreen,
        // primaryColor: Colors.grey[200],
        // scaffoldBackgroundColor: Colors.grey[100],
        // scaffoldBackgroundColor: Color(0xFFDCD6DA),
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
