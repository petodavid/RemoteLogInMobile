import 'package:flutter/material.dart';

class DeviceIsNotSupportedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          'Device is not supported or biometric identification is not enabled, check your settings.',
          style: TextStyle(
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
