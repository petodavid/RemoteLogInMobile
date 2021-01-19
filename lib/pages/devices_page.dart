import 'package:RemoteLogIn/core/colors.dart';
import 'package:RemoteLogIn/main.dart';
import 'package:RemoteLogIn/pages/qr_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QrScannerPage(),
              fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: KColors.appStartGradientColor,
        child: Icon(FontAwesomeIcons.plus),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .doc(googleSignIn.currentUser.id)
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
                return ListTile(
                  title: Text(clientIds[index]),
                  leading: Icon(
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
    );
  }
}
