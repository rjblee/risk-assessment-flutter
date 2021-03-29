import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class GetBrowser extends StatefulWidget {
  GetBrowser(this.address);

  final String address;

  @override
  GetBrowserState createState() => GetBrowserState();
}

class GetBrowserState extends State<GetBrowser> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.address,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
