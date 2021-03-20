import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class SignUpBrowser extends StatefulWidget {
  @override
  SignUpBrowserState createState() => SignUpBrowserState();
}

class SignUpBrowserState extends State<SignUpBrowser> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://swiftlearning.com/#!/signIn',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
