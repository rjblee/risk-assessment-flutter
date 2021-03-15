import 'package:flutter/material.dart';
import 'constants.dart';

class NextButton extends StatelessWidget {
  NextButton({this.buttonText, this.nextWidget});

  final String buttonText;
  final Widget nextWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(bottom: 40),
      child: ElevatedButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontFamily: 'YanoneKaffeesatz'),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return nextWidget;
          }));
        },
        style: ElevatedButton.styleFrom(
          primary: kAppBlue,
          onPrimary: kAppLight,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
