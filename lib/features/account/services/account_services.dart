import 'package:amazon_clone_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString('x-auth-token', '');
      navigator.pushNamedAndRemoveUntil(
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }
}
