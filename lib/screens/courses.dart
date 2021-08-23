import 'dart:async';
import 'package:flutter/material.dart';
import 'package:risk_assessment_flutter/appbar.dart';
import '../globals.dart' as globals;
import 'package:webview_flutter/webview_flutter.dart';

class Courses extends StatefulWidget {
  Courses(
      {this.contentID,
      this.resumeSession}); //Pass in the content id for which course is being looked at and if the session should be resumed
  final contentID;
  final resumeSession;

  @override
  _CoursesState createState() => _CoursesState();
}

class LocalLoader {
  Future<String> loadLocal(int content, bool resume) async {
    String URL = "https://sisfoundation.swiftlearning.com";
    String body = "request=340&authorization=7676BB3898DD1526FD96BB7912EC4277397B435E3ECD090B870FBE9E956F0227&email=" +
        globals.email +
        "&contentID=" +
        content.toString() +
        "&resumesession=" +
        resume.toString();
    Map headers = <String, String>{"Content-Type": "application/x-www-form-urlencoded", "accept": "applicaton/json"};
    var response = await globals.post(URL, headers, body);
    return response.body;
  }
}

class _CoursesState extends State<Courses> {
  WebViewController webViewController;
  deactivate() {
    final String postUrl = "'https://sisfoundation.swiftlearning.com/'";
    //  final String postUrl=await webViewController.currentUrl().toString();
    final String postParam = "{request: '201',sw_session_id:''}";
    final String requestMethod = "'post'";
    final String jsFunc = "function post(path, params, method='post') {" +
        "const form = document.createElement('form');" +
        "form.method = method;" +
        "form.action = path;" +
        "for (const key in params) {" +
        "if (params.hasOwnProperty(key)) {" +
        "const hiddenField = document.createElement('input');" +
        "hiddenField.type = 'hidden';" +
        "hiddenField.name = key;" +
        "hiddenField.value = params[key];" +
        "form.appendChild(hiddenField);}}document.body.appendChild(form);form.submit();}" +
        "post($postUrl, $postParam, method=$requestMethod)";
    webViewController.evaluateJavascript(
        jsFunc); //send the function into the webview as it is leaving in order to log the user out as they are finishing with their course.
    webViewController
        .clearCache(); //clear the browser cache in case anything could be left behind and mess up the next launch

    globals
        .login(); // Because the user has been logged out by accessing the course they will need to be logged into gems again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        child: FutureBuilder<String>(
          future: LocalLoader().loadLocal(widget.contentID, widget.resumeSession),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WebView(
                initialUrl: new Uri.dataFromString(snapshot.data, mimeType: 'text/html').toString(),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController w) {
                  webViewController = w; //set the more global variable so it can be accessed in other areas
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
