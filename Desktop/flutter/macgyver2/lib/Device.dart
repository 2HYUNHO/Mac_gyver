import 'package:flutter/material.dart';

class DevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey),
        title: Text(
          "디바이스 등록",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 19.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
      ),
      body: Padding(padding: const EdgeInsets.all(8.0), child: Center()),
    );
  }
}
