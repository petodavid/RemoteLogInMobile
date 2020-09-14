import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/widgets.dart';

import '../main.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () async {
            OkCancelResult result = await showOkCancelAlertDialog(
              context: context,
              title: 'Are you sure want log out?',
              isDestructiveAction: true,
            );
            if (result == OkCancelResult.ok) {
              await googleSignIn.disconnect();
            }
          },
          label: Row(
            children: [
              Icon(
                FontAwesomeIcons.signOutAlt,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Log out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
      body: ListView(
        children: [
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: currentUser,
            ),
            title: Text(currentUser.displayName ?? ''),
            subtitle: Text(currentUser.email ?? ''),
          ),
        ],
      ),
    );
  }
}
