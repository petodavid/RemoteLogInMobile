import 'package:RemoteLogIn/core/colors.dart';
import 'package:RemoteLogIn/pages/device_is_not_supported.dart';
import 'package:RemoteLogIn/pages/home_page.dart';
import 'package:RemoteLogIn/pages/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RemoteLogIn());
}

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
GoogleSignInAccount currentUser;

class RemoteLogIn extends StatefulWidget {
  @override
  _RemoteLogInState createState() => _RemoteLogInState();
}

class _RemoteLogInState extends State<RemoteLogIn> {
  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
      });
    });
    googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  KColors.appStartGradientColor,
                  KColors.appEndGradientColor,
                ],
              ),
            ),
          ),
          title: Text(
            'Remote LogIn',
          ),
        ),
        body: FutureBuilder<bool>(
          future: LocalAuthentication().canCheckBiometrics,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data) {
              if (currentUser != null) {
                return HomePage();
              }
              return LogInPage();
            }
            return DeviceIsNotSupportedPage();
          },
        ),
      ),
    );
  }
}
