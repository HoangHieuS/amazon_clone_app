import 'dart:convert';

import 'package:amazon_clone_app/features/admin/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../common/widgets/widgets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';

class AuthService {
  const AuthService();

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          SnackBarUtil.showSnackBar(     
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      SnackBarUtil.showSnackBar( e.toString());
    }
  }

  signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final navigator = Navigator.of(context);
          final provider = Provider.of<UserProvider>(context, listen: false);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          provider.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          navigator.pushNamedAndRemoveUntil(
            provider.user.type == 'user' ? 
            BottomBar.routeName : AdminScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      SnackBarUtil.showSnackBar( e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        userProvider.setUser(userRes.body);  
      }
    } catch (e) {
      SnackBarUtil.showSnackBar( e.toString());
    }
  }
}
