import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import 'dart:io';
import 'industry.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //   border: Border(
            //     top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
            //     left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
            //     right: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
            //     bottom: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
            //   ),
            //   color: Color(0xFFBFBFBF),
            // ),
            child: Text(
              'Sign in with your \nSafety in Schools Credentials',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 200,
            child: Image.asset('images/Swift Learning Logo.png'),
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
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'This is the same account you use to access \nyour courses on Swift Learning.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  launchURL('https://swiftlearning.com/#!/signIn');
                  // const WebView(
                  //   initialUrl: 'https://swiftlearning.com/#!/signIn',
                  //   javascriptMode: JavascriptMode.unrestricted,
                  // );
                },
                color: Colors.blue[800],
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                splashColor: Colors.blueGrey,
                elevation: 10,
              ),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Color(0XFFB5121B),
                textColor: Color(0xFFFFFFFF),
                elevation: 10,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Industry();
                  }));
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ----- URL launching Flutter package -----

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// class WebView extends StatefulWidget {
//   WebView(this.url);
//
//   final url;
//
//   @override
//   _WebViewState createState() => _WebViewState(this.url);
// }
//
// class _WebViewState extends State<WebView> {
//   _WebViewState(this.url);
//
//   String _url;
//
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: WebView(
//         initialUrl: _url,
//       ),
//     );
//   }
// }
