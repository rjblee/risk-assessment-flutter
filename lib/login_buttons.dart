import 'dart:convert';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

class LoginButtons extends StatelessWidget {
  LoginButtons({this.username, this.password, this.buttonText, this.request, this.Message, this.onChange});

  final TextEditingController username;
  final TextEditingController password;
  final String buttonText;
  final int request;
  final Function onChange;
  String Message;
  var sharedPrefs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(bottom: 40),
      child: ElevatedButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
        ),
        onPressed: () async {
          LoginFunctions();
        },
        style: ElevatedButton.styleFrom(
          primary: kAppBlue,
          // onPrimary: kAppLight,
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

  @override
  Future LoginFunctions() async {
    String ServerUrl = "https://swiftapi.swiftlearning.com/api/v1/api_sessions";
    String body = "";
    var headers = <String, String>{"Content-Type": "application/x-www-form-urlencoded", "accept": "applicaton/json"};
    switch (request) {
      case 1:
        body = "Username=" +
            username.text.toString().trim() +
            "&Password=" +
            password.text.toString().trim() +
            "&server=&gemskey=";
        break;
      case 0: //If the logout function has been called
        if (globals.user == null) //if there is no object just print an error message on the bottom message
        {
          onChange('You Were Already Logged Out');
          return;
        } else {
          body = "auth_token=" + globals.user['auth_token'];
        }
        break;
      default:
        onChange("Error: There is something wrong please contact one of our developers");
    }
    var result = await sendRequest(ServerUrl, headers, body);
    if (result != null) {
      onChange(result);
    }
  }

  @override
  Future<String> sendRequest(String URL, Map<String, String> Headers, String Body) async {
    switch (request) {
      case 1:
        final response = await http.post(Uri.parse(URL), headers: Headers, body: Body);

        /*
        if(response.headers['set-cookie']==null) {
          return "Error: Not able to Log In.\nYou may have another active session.\nPlease close your other sessions or Force Login";
          //return 'Sucess';
        }
        else{//when there is no error save the session ID to local preferences to be used in the logout and possibly other functions
          var cookie=response.headers['set-cookie'].split(';')[0];//Get the cookie returned by the API call to be used for logging the user off or calling other APIs
          globals.session_id=cookie;
          return "Sucess";
        }*/
        Map<String, dynamic> user = jsonDecode(response.body);
        if (user['status'] ==
            200) //if there is no issue with the login the status will be 200 and the user will be logged in
        {
          globals.user = user;
          globals.email = user['account'];
          globals.password = password.text.toString();
          return 'Sucess';
        } else {
          globals.user = null; //set the user to be nothing so no information is found
          globals.email = ""; //reset the email and password in case they are not found
          globals.password = "";
          return user['errorMsg'];
        }
        break;

      case 0:
        final response = await http.delete(Uri.parse(URL), headers: Headers, body: Body);
        Map<String, dynamic> logout = jsonDecode(response.body);
        if (logout['status'] == 204) //Successfully logged out and set the user to null
        {
          globals.user = null;
          return logout['message'];
        } else {
          return logout['message'];
        }
        break;
    }
  }
}
