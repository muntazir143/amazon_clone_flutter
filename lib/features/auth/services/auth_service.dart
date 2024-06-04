import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signupUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          type: "",
          address: "",
          token: "");

      http.Response response = await http.post(
        Uri.parse("$uri/api/signup"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: user.toJson(),
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, "Account created!");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                "x-auth-token", jsonDecode(response.body)["token"]);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
