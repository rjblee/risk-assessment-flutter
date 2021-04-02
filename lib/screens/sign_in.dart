import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import 'industry.dart';
import '../get_browser.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Sign in with your Safety in Schools Credentials',
                    textAlign: TextAlign.center,
                    style: kSubHeaderTextStyle,
                  ),
                ),
                Container(
                  child: Image.asset('images/Swift Learning Logo.png', height: 120),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'This is the same account you use to \naccess your courses on Swift Learning.',
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Your email',
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Your password',
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                NextButton(
                  buttonText: 'Log In',
                  nextWidget: Industry(),
                ),
                // Container(
                //   width: 300,
                //   padding: EdgeInsets.only(bottom: 20),
                //   child: ElevatedButton(
                //     child: Text(
                //       'Log In',
                //       style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                //     ),
                //     onPressed: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                //         return Industry();
                //       }));
                //     },
                //     style: ElevatedButton.styleFrom(
                //       primary: kAppBlue,
                //       onPrimary: kAppLight,
                //       elevation: 10,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       // padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                //       padding: EdgeInsets.symmetric(vertical: 14),
                //     ),
                //   ),
                // ),
                NextButton(
                  buttonText: 'Create an Account',
                  nextWidget: GetBrowser('https://swiftlearning.com/#!/signIn'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----- URL launching Flutter package -----

// void launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
