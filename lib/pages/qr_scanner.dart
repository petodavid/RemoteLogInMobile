import 'package:RemoteLogIn/core/colors.dart';
import 'package:RemoteLogIn/main.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPage extends StatefulWidget {
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'QR Scanning',
        ),
      ),
      body: QRView(
        key: GlobalKey(debugLabel: 'QR'),
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    String myUserId = googleSignIn.currentUser.id;
    controller.scannedDataStream.listen((scanData) {
      controller.dispose();
      Firestore.instance.collection("client").getDocuments().then(
        (querySnapshot) {
          var data = querySnapshot.documents;
          var iDs = data.map((e) => e.id);
          if (iDs.contains(scanData)) {
            Firestore.instance.collection("user").document(myUserId).setData(
              {
                "clients": FieldValue.arrayUnion([scanData]),
              },
              SetOptions(merge: true),
            ).then((_) {
              showOkAlertDialog(
                context: context,
                title: 'Success:',
                message: scanData,
              ).then((value) {
                Navigator.pop(context);
              });
            });
          } else {
            showOkAlertDialog(
              context: context,
              title: 'No Client found with id:',
              message: scanData,
            ).then((value) {
              Navigator.pop(context);
            });
          }
        },
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
