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
                  child: Image.asset('images/Swift Learning New Logo.png', height: 100),
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
                          hintText: 'Enter your email',
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
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
