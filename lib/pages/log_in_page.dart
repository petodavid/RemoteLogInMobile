import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleSignInButton(
        onPressed: handleSignIn,
      ),
    );
  }

  Future<void> handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
