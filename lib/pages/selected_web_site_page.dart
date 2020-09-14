import 'package:RemoteLogIn/core/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

import '../main.dart';

class SelectedWebSitePage extends StatefulWidget {
  final String page;
  SelectedWebSitePage({@required this.page});

  @override
  _SelectedWebSitePageState createState() => _SelectedWebSitePageState();
}

class _SelectedWebSitePageState extends State<SelectedWebSitePage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedMachineId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: KColors.appStartGradientColor,
          onPressed: () async {
            var localAuth = LocalAuthentication();
            bool didAuthenticate = await localAuth.authenticateWithBiometrics(
                localizedReason:
                    'To open the webpage on your machine we need to first a authenticate you');
            if (didAuthenticate) {
              await Firestore.instance
                  .collection("client")
                  .document(selectedMachineId)
                  .setData({
                'page': widget.page,
                'userName': username.text,
                'password': password.text,
              });
            } else {
              final snackBar = SnackBar(
                content: Text('Authentication failed'),
                backgroundColor: Colors.red,
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          label: Row(
            children: [
              Icon(FontAwesomeIcons.desktop),
              SizedBox(
                width: 20,
              ),
              Text('Open on my machine')
            ],
          )),
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
          widget.page,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                controller: username,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email / Username'),
              ),
            ),
            Expanded(
              child: TextField(
                controller: password,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            Expanded(
              flex: 2,
              child: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection("user")
                    .document(googleSignIn.currentUser.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.exists) {
                    var clientIds = (snapshot.data.data()['clients'] as List)
                        ?.map((item) => item as String)
                        ?.toList();
                    if (clientIds == null || clientIds.isEmpty) {
                      return Center(
                        child: Text('Empty Devices'),
                      );
                    }
                    return ListView.builder(
                      itemCount: clientIds.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: selectedMachineId == clientIds[index],
                          onChanged: (value) {
                            setState(() {
                              value
                                  ? selectedMachineId = clientIds[index]
                                  : selectedMachineId = null;
                            });
                          },
                          title: Text(clientIds[index]),
                          secondary: Icon(
                            FontAwesomeIcons.desktop,
                            color: KColors.appStartGradientColor,
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasData && !snapshot.data.exists) {
                    return Center(
                      child: Text('Empty Devices'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
