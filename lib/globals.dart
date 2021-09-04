library my_prj.globals;

import 'dart:convert';
import 'package:http/http.dart' as http;

String email = ""; // the email to be stored so later on the user can be logged in again
String password = ""; //the password to be stored in order for the user to be logged in again if needed
var user; //The user object which is what is returned by the login function and will have the auth key and other important information

//below here are the functions that can be accessed globally these are mainly used for logging in or out and can be used all over the application

void login() async {
  if (email != "" &&
      password !=
          "") //check to see if there are values for logging a user in or not so it cannot be used if they are already logged in
  {
    if (user != null) //If the user object is not null it will log them in
    {
      bool loggedIn = await checkAuthToken(user[
          'auth_token']); //check to see if the user is already logged in if they are there is no need to log them in again
      if (loggedIn == false) {
        user = null; //set the user to be null in case of any duplication
        String ServerUrl = "https://swiftapi.swiftlearning.com/api/v1/api_sessions";
        var headers = <String, String>{
          "Content-Type": "application/x-www-form-urlencoded",
          "accept": "applicaton/json"
        };
        String body = "Username=" + email + "&Password=" + password + "&server=&gemskey=";
        var response = await post(ServerUrl, headers, body);
        Map<String, dynamic> loginObject = jsonDecode(response.body);
        if (loginObject['status'] ==
            200) //if there is no issue with the login the status will be 200 and the user will be logged in
        {
          user = loginObject;
          email = loginObject['account'];
        } else {
          print(loginObject['errorMsg']);
        }
      }
    }
  } else {
    print('ERROR THERE IS AN ERROR WHILE LOGGING IN\n\n\n');
    print('user Object: $user\n');
    print('email: $email\n');
    print('password: $password\n');
  }
}

void logout() async {
  if (user != null) {
    String URL = "https://swiftapi.swiftlearning.com/api/v1/api_sessions";
    var headers = <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "accept": "applicaton/json",
    };
    String body = "auth_token=" + user['auth_token'];
    final response = await http.delete(Uri.parse(URL), headers: headers, body: body);
    Map<String, dynamic> logout = jsonDecode(response.body);
    if (logout['status'] == 204) {
      print(logout['message']);
      user = null;
      email = "";
      password = "";
    } else {
      print(logout['message']);
      email = "";
      password = "";
    }
  }
}

Future<bool> checkAuthToken(String authToken) async {
  //check the auth token stored in the previous user object
  if (authToken != "") {
    String authUrl = "https://swiftapi.swiftlearning.com/api/v1/check_auth_token";
    var headers = <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "accept": "applicaton/json",
    };
    String authBody = "auth_token=" + authToken;
    var authResponse = await post(authUrl, headers, authBody);
    Map<String, dynamic> authorized = jsonDecode(authResponse.body);
    if (authorized['authorized'] == true) {
      return true;
    } else {
      return false;
    }
  } else {
    print('ERROR AUTH TOKEN NOT PASSED IN\n\n\n\n\n\n\n\n\n');
  }
}

Future<http.Response> post(String URL, Map<String, String> Headers, String Body) async {
  return await http.post(Uri.parse(URL), headers: Headers, body: Body);
}
