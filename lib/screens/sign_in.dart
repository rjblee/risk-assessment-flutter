import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'package:risk_assessment_flutter/constants.dart';
import 'package:risk_assessment_flutter/login_buttons.dart';
import 'package:risk_assessment_flutter/next_button.dart';
import 'industry.dart';
import '../globals.dart' as globals;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    //whenever the sign in page is disposed it will call the log out function and clear the stored information
    super.dispose();
    globals.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              //Do not allow any whitespace to be added to the password fields
                              new RegExp(r"\s\b|\b\s"))
                        ],
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

                // Login Button connecting with the Swift Learning authentication
                // LoginButtons(
                //   buttonText: "Log In",
                //   username: usernameController,
                //   password: passwordController,
                //   request: 1,
                //   onChange: (Message) {
                //     if (Message != "Sucess") //When there is an error message it will display in the bottom
                //     {
                //       scaffoldKey.currentState.showSnackBar(SnackBar(content: new Text("$Message")));
                //       this.passwordController.text = "";
                //     } else {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                //         return Industry();
                //       }));
                //       this.passwordController.text = "";
                //       this.usernameController.text = "";
                //     }
                //   },
                // ),
                NextButton(
                  buttonText: 'Log In',
                  nextWidget: Industry(),
                ),
                /*LoginButtons(
                    buttonText: 'Log Out',
                    //username: usernameContoller,
                    //password: passwordController,
                    request: 0,
                    onChange:(Message){
                      scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: new Text("$Message"))
                      );
                      this.passwordController.text="";
                      this.usernameController.text="";
                    }
                ),*/
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
